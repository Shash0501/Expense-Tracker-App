import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:money_manager/models/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) {
      if (event is testeventt) {
        print("mai hun bewakoof");
      }
    });
  }
}
