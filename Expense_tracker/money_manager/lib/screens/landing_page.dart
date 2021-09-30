import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/constants/months.dart';
import 'package:money_manager/constants/text_styles.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:money_manager/blocs/Category_bloc/category_bloc.dart';
import 'package:money_manager/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/screens/add_transaction_page.dart';
import 'package:money_manager/screens/categories_page.dart';
import 'package:money_manager/widgets/transaction_tile.dart';
import 'package:quiver/time.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var transactionbox = Hive.box<TransactionModel>('transactions');
  String AppbarActionLabel = "Month";
  // List<Widget> DatesListWidget = DatesList.map((e) => Text(e)).toList();
  int temp1 = 1;
  String month = Months[DateTime.now().month - 1];
  int days = daysInMonth(2021, (DateTime.now().month) + 1);
  List<String> DatesList = [];
  Future<void> showMonthDialogBox(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: _buildDropdownButton(),
          );
        });
  }

  Widget _buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 65.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: temp1 > 0 ? Colors.grey : Colors.red, width: 1),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: month,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            items: Months.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() {
              month = value.toString();
              setState(() {
                days = (daysInMonth(2021, Months.indexOf(month) + 1));
                DatesList.clear();
                for (int i = 1; i <= days; i++) {
                  DatesList.add(
                    (i.toString()),
                  );
                }
              });
              Navigator.pop(context);
            }),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<TransactionBloc>(context).add(DateWiseTransaction(
        date: DateTime.now().day, month: DateTime.now().month));
    days = (daysInMonth(2021, Months.indexOf(month) + 1));
    DatesList.clear();
    for (int i = 1; i <= days; i++) {
      DatesList.add(i.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: DatesList.length,
      initialIndex: month != "February" ? DateTime.now().day - 1 : 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Money Manager'),
          actions: [
            TextButton(
                onPressed: () {
                  showMonthDialogBox(context);
                },
                child: Text(
                  month,
                  style: lpAb,
                )),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: TabBar(
                onTap: ((index) {
                  BlocProvider.of<TransactionBloc>(context).add(
                    DateWiseTransaction(
                        date: index + 1, month: Months.indexOf(month) + 1),
                  );
                }),
                labelColor: Colors.white,
                labelStyle: const TextStyle(fontSize: 25),
                unselectedLabelStyle: const TextStyle(fontSize: 15),
                isScrollable: true,
                controller: DefaultTabController.of(context),
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.green,
                tabs: DatesList.map((e) => Tab(
                      child: Text(e),
                    )).toList()),
          ),
        ),
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is DateWiseTransactionLoaded) {
              return ListView.builder(
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    TransactionModel Transaction = state.transactions[index];
                    return TransactionTile(
                      transactionAmount: Transaction.transactionAmount,
                      transactionCategory: Transaction.transactionCategory,
                      transactionDate: Transaction.transactionDate,
                      transactionDescription:
                          Transaction.transactionDescription,
                      transactionColor: Transaction.transactionColor,
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
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
                            child: const Add_Transaction(),
                          )));
            }),
      ),
    );
  }
}

void Show_MonthPicker(BuildContext context) {}
