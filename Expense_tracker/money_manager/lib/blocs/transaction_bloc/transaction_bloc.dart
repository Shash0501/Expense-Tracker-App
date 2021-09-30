import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/constants/piedata.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  var cbox = Hive.box<Category>('categories');
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

        emit(DateWiseTransactionLoaded(transactions: list));
      } else if (event is RefreshEvent) {
        emit(RefreshState());
      } else if (event is GetStatsEvent) {
        double totalExpense = 0;
        Map<String, double> CategoryList = {};
        List<int> categoryColor = [];
        List<Data> pieData = [];

        cbox.values.forEach((e) {
          CategoryList[e.categoryName] = 0;
          categoryColor.add(e.categoryColor);
        });
        box.values.forEach((e) {
          totalExpense += e.transactionAmount;
          double? a = CategoryList[e.transactionCategory];
          CategoryList[e.transactionCategory] = e.transactionAmount + a!;
        });
        for (int i = 0; i < CategoryList.length; i++) {
          pieData.add(Data(
              CategoryColor: categoryColor[i],
              CategoryExpense: CategoryList[cbox.getAt(i)!.categoryName]!,
              CategoryName: cbox.getAt(i)!.categoryName));
        }
        PieData piedata = PieData(data: pieData);
        emit(StatsLoaded(pieData: piedata, totalExpense: totalExpense));
      }
    });
  }
}
