import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:money_manager/blocs/Category_bloc/category_bloc.dart';
import 'package:money_manager/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/screens/add_transaction_page.dart';
import 'package:money_manager/screens/categories_page.dart';
import 'package:money_manager/widgets/transaction_tile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var transactionbox = Hive.box<TransactionModel>('transactions');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Money Manager'),
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable:
            Hive.box<TransactionModel>('transactions').listenable(),
        builder: (context, box, _) {
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                TransactionModel Transaction =
                    box.getAt(box.length - index - 1);
                return TransactionTile(
                  transactionAmount: Transaction.transactionAmount,
                  transactionCategory: Transaction.transactionCategory,
                  transactionDate: Transaction.transactionDate,
                  transactionDescription: Transaction.transactionDescription,
                  transactionColor: Transaction.transactionColor,
                );
              });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                          value: CategoryBloc(), child: CategoriesPage())));
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq),
              label: 'Transactions',
            )
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                          value: TransactionBloc(),
                          child: Add_Transaction(),
                        )));
          }),
    );
  }
}
