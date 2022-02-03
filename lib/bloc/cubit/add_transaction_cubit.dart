import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  AddTransactionCubit() : super(AddTransactionIncomeState("Income"));

  void incomeState() => emit(AddTransactionIncomeState("Income"));
  void expenseState() => emit(AddTransactionExpanseState("Expense"));
}
