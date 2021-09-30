import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:money_manager/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  double transactionAmount;
  String transactionCategory;
  String transactionDate;
  String transactionDescription;
  int transactionColor;
  String transactionId;
  TransactionTile(
      {required this.transactionId,
      required this.transactionAmount,
      required this.transactionCategory,
      required this.transactionColor,
      required this.transactionDate,
      required this.transactionDescription});
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<TransactionModel>('transactions');
    return Card(
      color: const Color(0x2B000000),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  transactionCategory.toUpperCase(),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(transactionColor),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(transactionDate),
              ]),
              const Spacer(
                flex: 1,
              ),
              Text(transactionAmount.toString()),
              IconButton(
                  onPressed: () {
                    showAlertDialog(context, box, transactionId);
                  },
                  icon: const Icon(Icons.delete)),
              IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: () => showSimpleDialog(
                      context,
                      transactionDescription,
                      transactionAmount,
                      transactionDate))
            ]),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, var box, String transactionId) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: const Text(
                'Are you sure you want to delete this Transaction ?'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    for (int i = 0; i < box.length; i++) {
                      if (box.getAt(i)!.transactionid == transactionId) {
                        box.deleteAt(i);
                      }
                    }
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ]);
      });
}

// a = transactionDescription
// b = transactionAmount
// c = transactionCategory
void showSimpleDialog(BuildContext context, String a, double b, String c) =>
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              contentPadding: const EdgeInsets.all(10),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              insetPadding: const EdgeInsets.all(20),
              title: Text(
                a.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 45),
              ),
              children: <Widget>[
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const SizedBox(height: 7),
                Text(
                  "Amount - ${b.toString()}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text("Date - $c ", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10)
              ]);
        });
