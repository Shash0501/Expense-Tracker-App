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
      }
    });
  }
}
