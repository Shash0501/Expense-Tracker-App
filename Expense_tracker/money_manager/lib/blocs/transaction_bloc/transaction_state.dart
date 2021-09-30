part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class DateWiseTransactionLoaded extends TransactionState implements Equatable {
  List<TransactionModel> transactions;
  DateWiseTransactionLoaded({required this.transactions});
  @override
  List<Object> get props => [transactions];
}

class RefreshState extends TransactionState {}

class StatsLoaded extends TransactionState {
  PieData pieData;
  double totalExpense;
  StatsLoaded({required this.pieData, required this.totalExpense});
}
