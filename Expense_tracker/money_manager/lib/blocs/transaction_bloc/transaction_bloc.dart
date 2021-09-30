import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  var box = Hive.box<TransactionModel>('transactions');
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) {
      if (event is AddTransaction) {
        box.add(event.transaction);
      } else if (event is DateWiseTransaction) {
        int date1 = event.date;
        int month1 = event.month;
        List<TransactionModel> list = box.values.where((element) {
          int date = int.parse(element.transactionDate.split('/')[0]);
          int month = int.parse(element.transactionDate.split('/')[1]);
          if (date == date1 && month == month1) {
            return true;
          } else {
            return false;
          }
        }).toList();
        print("hello");

        emit(DateWiseTransactionLoaded(transactions: list));
      }
    });
  }
}
