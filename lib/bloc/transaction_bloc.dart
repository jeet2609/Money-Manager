import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/modals/transaction_modal.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  Box box = Hive.box("money");

  late List<TransactionModel> data;
  var totalBalance = 0;
  var totalIncome = 0;
  var totalExpense = 0;
  DateTime today = DateTime.now();
  List<FlSpot> dataSet = [];


  TransactionBloc() : super(TransactionInitialState()) {
    on<TransactionEvent>((event, emit) {});
    on<LoadDataEvent>(_loadData);
  }

  Future<void> _loadData(
      LoadDataEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoadingState());
    print("data loadng");

    data = await _fetch();
    print("data Loaded");
    getTotalBalance(data);
    getPlotPoints(data);
    emit(TransactionLoadedState(dataSet: dataSet, data: data, totalBalance: totalBalance, totalExpense: totalExpense, totalIncome: totalIncome));
  }

  Future<List<TransactionModel>> _fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<TransactionModel> item = [];

      box.toMap().values.forEach(
        (element) {
          item.add(
            TransactionModel(
              element["amount"] as int,
              element["date"] as DateTime,
              element["description"],
              element["type"],
            ),
          );
        },
      );

      // sort the data
      item.sort((a, b) => a.date.day - b.date.day);

      return item;
    }
  }

  getTotalBalance(List<TransactionModel> entireData) {
    print('getTotalBalance called');
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
  List<FlSpot> getPlotPoints(List<TransactionModel> entireData) {
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

}
