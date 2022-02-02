import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/bloc/transaction_bloc.dart';
import 'package:money_manager/controller/db_helper.dart';
import 'package:money_manager/modals/transaction_modal.dart';
import 'package:money_manager/pages/add_transaction.dart';
import 'package:money_manager/pages/widget/balance_card.dart';
import 'package:money_manager/pages/widget/chart.dart';
import 'package:money_manager/pages/widget/header.dart';
import 'package:money_manager/pages/widget/recent_transactions.dart';

import '../static.dart' as Static;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();

  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  List<FlSpot> dataSet = [];
  DateTime today = DateTime.now();

  String name = "";

  late Box box;

  _getTotalBalance(List<TransactionModel> entireData) {
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;

    for (TransactionModel data in entireData) {
      if (data.date.month == today.month) {
        if (data.type == "Income") {
          totalBalance += data.amount;
          totalIncome += data.amount;
        } else {
          totalBalance -= data.amount;
          totalExpense += data.amount;
        }
      }
    }
  }

  List<FlSpot> _getPlotPoints(List<TransactionModel> entireData) {
    List tempDataSet = [];
    dataSet = [];

    for (TransactionModel data in entireData) {
      if (data.date.month == today.month && data.type == "Expense") {
        tempDataSet.add(data);
      }
    }

    tempDataSet.sort((a, b) => a.date.day - b.date.day);

    // remove duplicate data (need to optimise)
    if (tempDataSet.length > 1) {
      int currDataIndex = tempDataSet.length - 1;
      int i = tempDataSet.length - 2;

      while (i >= 0) {
        if (tempDataSet[currDataIndex].date.day == tempDataSet[i].date.day) {
          var amount = tempDataSet[currDataIndex].amount;

          while (i >= 0 &&
              tempDataSet[currDataIndex].date.day == tempDataSet[i].date.day) {
            amount += tempDataSet[i].amount;
            i--;
          }

          dataSet.add(
            FlSpot(
              tempDataSet[currDataIndex].date.day.toDouble(),
              amount.toDouble(),
            ),
          );

          currDataIndex = i;
          i = currDataIndex - 1;
        } else {
          dataSet.add(
            FlSpot(
              tempDataSet[currDataIndex].date.day.toDouble(),
              tempDataSet[currDataIndex].amount.toDouble(),
            ),
          );

          currDataIndex--;
          i--;
        }
      }

      if (currDataIndex == 0) {
        dataSet.add(
          FlSpot(
            tempDataSet[0].date.day.toDouble(),
            tempDataSet[0].amount.toDouble(),
          ),
        );
      }
    } else if (tempDataSet.length == 1) {
      dataSet.add(
        FlSpot(
          tempDataSet[0].date.day.toDouble(),
          tempDataSet[0].amount.toDouble(),
        ),
      );
    }

    return dataSet;
  }

  _getName() async {
    name = await dbHelper.getName();
  }

  @override
  void initState() {
    super.initState();
    _getName();
    box = Hive.box("money");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TransactionBloc>().add(LoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        //
        backgroundColor: Color(
          0xffe2e7ef,
        ),
        //
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 32.0,
          ),
          backgroundColor: Static.PrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => AddTransaction(),
                  ),
                )
                .whenComplete(
                  () => {
                    setState(() {}),
                  },
                );
          },
        ),
        //
        body: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {
            print(state);
          },
          //
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              print(state);
              return CircularProgressIndicator();
            } else if (state is TransactionLoadedState) {
              _getTotalBalance(state.data);
              //
              _getPlotPoints(state.data);
              //
              return ListView(
                children: [
                  // upper header
                  getHeader(
                    name,
                  ),
                  // Balane Card
                  getBalanceCard(
                    context,
                    totalBalance,
                    totalIncome,
                    totalExpense,
                  ),
                  // Render Chart
                  getChart(
                    dataSet,
                  ),
                  // Recent Transactions
                  getRecentTransaction(
                    context,
                    dbHelper,
                    state,
                  ),
                ],
              );
            } else {
              return Text("Nothing here");
            }
          },
        ));
  }
}
