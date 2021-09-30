import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  var box = Hive.box<Category>('categories');
  var tbox = Hive.box<TransactionModel>('transactions');
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      if (event is AddCategory) {
        event.box.add(event.category);
        emit(state);
      } else if (event is CategoryTabChanged) {
        String catname = event.name;
        List<TransactionModel> transactions = tbox.values.where((transac) {
          return transac.transactionCategory == catname;
        }).toList();
        emit(CategoryTabLoaded(transactions: transactions));
      }
    });
  }
}
