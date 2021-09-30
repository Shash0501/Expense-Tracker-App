part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class testeventt extends TransactionEvent {}

class AddTransaction extends TransactionEvent {
  final TransactionModel transaction;
  AddTransaction({required this.transaction});
}

class DateWiseTransaction extends TransactionEvent {
  int date;
  int month;
  DateWiseTransaction({required this.date, required this.month});
}

class RefreshEvent extends TransactionEvent {}

class GetStatsEvent extends TransactionEvent {}
