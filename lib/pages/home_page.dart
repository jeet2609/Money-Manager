import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/bloc/transaction_bloc.dart';
import 'package:money_manager/controller/db_helper.dart';
import 'package:money_manager/pages/add_transaction_page.dart';
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

  String name = "";
  late Box box;

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
        backgroundColor: const Color(
          0xffe2e7ef,
        ),
        //
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddTransaction(),
              ),
            );
          },
        ),
        //
        body: BlocConsumer<TransactionBloc, TransactionState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is TransactionLoadedState) {
              return ListView(
                children: [
                  // upper header
                  getHeader(name),
                  // Balance Card
                  getBalanceCard(context, state.totalBalance, state.totalIncome,
                      state.totalExpense),
                  // Render Chart
                  getChart(state.dataSet),
                  // Recent Transactions
                  getRecentTransaction(context, dbHelper, state),
                ],
              );
            } else {
              return const Text("Nothing here");
            }
          },
        ));
  }
}
