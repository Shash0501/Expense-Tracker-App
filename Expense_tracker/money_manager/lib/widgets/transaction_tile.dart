import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  double transactionAmount;
  String transactionCategory;
  String transactionDate;
  String transactionDescription;
  int transactionColor;
  TransactionTile(
      {required this.transactionAmount,
      required this.transactionCategory,
      required this.transactionColor,
      required this.transactionDate,
      required this.transactionDescription});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0x2B000000),
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
              Text(transactionAmount.toString()),
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
                style: TextStyle(fontSize: 45),
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
