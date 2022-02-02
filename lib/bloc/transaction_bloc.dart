import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:money_manager/modals/transaction_modal.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  Box box = Hive.box("money");

  TransactionBloc() : super(TransactionInitialState()) {
    on<TransactionEvent>(
      (event, emit) {},
    );
    on<LoadDataEvent>(_loadData);
  }

  Future<void> _loadData(
      LoadDataEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoadingState());
    print("data loadng");

    List<TransactionModel> data = await _fetch();
    print("data Loaded");

    emit(TransactionLoadedState(data));
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
}
