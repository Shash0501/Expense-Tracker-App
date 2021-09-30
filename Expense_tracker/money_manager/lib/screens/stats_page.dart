import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:money_manager/constants/months.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_manager/constants/piedata.dart';

class TransactionStatsPage extends StatefulWidget {
  TransactionStatsPage({Key? key}) : super(key: key);

  @override
  _TransactionStatsPageState createState() => _TransactionStatsPageState();
}

class _TransactionStatsPageState extends State<TransactionStatsPage> {
  List<String> months = Months;
  int initialMonth = DateTime.now().month;
  @override
  void initState() {
    BlocProvider.of<TransactionBloc>(context).add(GetStatsEvent());
    super.initState();
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                              color: Colors.black,
                              onPressed: () {
                                if (initialMonth != 1) {
                                  setState(() {
                                    initialMonth--;
                                  });
                                }
                              },
                              icon: Icon(Icons.arrow_back)),
                          Text(
                            months[initialMonth - 1],
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          IconButton(
                              color: Colors.black,
                              onPressed: () {
                                if (initialMonth != 12) {
                                  setState(() {
                                    initialMonth++;
                                  });
                                }
                              },
                              icon: Icon(Icons.arrow_forward)),
                        ],
                      ),
                      height: 40,
                      // width: 100,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                color: Colors.white,
              ),
              Card(child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is StatsLoaded) {
                    return Column(children: [
                      SizedBox(
                        width: 500,
                        height: 300,
                        child: PieChart(PieChartData(
                          centerSpaceRadius: 60,
                          sections:
                              getsections(state.pieData, state.totalExpense),
                        )),
                      ),
                    ]);
                  } else {
                    return Container();
                  }
                },
              ))
            ],
          )),
    );
  }
}

List<PieChartSectionData> getsections(PieData pieData, double total) {
  return pieData.data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: Color(data.CategoryColor),
          value: (data.CategoryExpense) / total,
          // ignore: unnecessary_string_interpolations
          title:
              '${((data.CategoryExpense * 100) / total).toString().substring(0, 4)}',
          titleStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );

        return MapEntry(index, value);
      })
      .values
      .toList();
}
