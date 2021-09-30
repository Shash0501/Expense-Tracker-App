import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/blocs/transaction_bloc/transaction_bloc.dart';

class TransactionStatsPage extends StatefulWidget {
  TransactionStatsPage({Key? key}) : super(key: key);

  @override
  _TransactionStatsPageState createState() => _TransactionStatsPageState();
}

class _TransactionStatsPageState extends State<TransactionStatsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Transaction Stats'),
              bottom: const TabBar(tabs: [
                Tab(
                  text: 'Yearly',
                ),
                Tab(
                  text: 'Monthly',
                ),
              ])),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                ),
              )
            ],
          )),
    );
  }
}
