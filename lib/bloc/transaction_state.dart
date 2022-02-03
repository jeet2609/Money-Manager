part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionLoadedState extends TransactionState {
  final List<TransactionModel> data;

  final int totalBalance;
  final int totalIncome;
  final int totalExpense;
  final List<FlSpot> dataSet;

  TransactionLoadedState({required this.dataSet, required this.data, required this.totalBalance, required this.totalIncome, required this.totalExpense});
  
  @override
  List<Object?> get props => [data, totalBalance, totalExpense, totalIncome];
}
