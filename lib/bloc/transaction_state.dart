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
  TransactionLoadedState(this.data);
  
  @override
  List<Object?> get props => [data];
}
