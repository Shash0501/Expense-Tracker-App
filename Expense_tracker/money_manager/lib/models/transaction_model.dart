import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  double transactionAmount;

  @HiveField(1)
  String transactionCategory;

  @HiveField(2)
  String transactionDate;

  @HiveField(3)
  String transactionDescription;

  @HiveField(4)
  int transactionColor;

  @HiveField(5)
  String transactionid;

  TransactionModel(
      {required this.transactionAmount,
      required this.transactionCategory,
      required this.transactionDate,
      required this.transactionDescription,
      required this.transactionColor,
      required this.transactionid});
}
