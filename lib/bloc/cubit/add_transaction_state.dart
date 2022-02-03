part of 'add_transaction_cubit.dart';

abstract class AddTransactionState extends Equatable {
  // AddTransactionState({
  //   required this.type,
  // });

  AddTransactionState({
    required this.type,
  });

  @override
  List<Object> get props => [];

  String type = "";
}

class AddTransactionIncomeState extends AddTransactionState {
  AddTransactionIncomeState(String myType) : super(type: myType);
}

class AddTransactionExpanseState extends AddTransactionState {
   AddTransactionExpanseState(String myType) : super(type: myType);
}