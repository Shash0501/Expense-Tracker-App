import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/blocs/Category_bloc/category_bloc.dart';
import 'package:money_manager/blocs/Transaction_bloc/transaction_bloc.dart';

import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/widgets/category_tile.dart';
import 'package:money_manager/widgets/transaction_tile.dart';

import 'add_category_screen.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<CategoryBloc>(context)
        .add(CategoryTabChanged(name: 'Food'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Category> categoriesList =
        Hive.box<Category>('categories').values.toList().map((c) => c).toList();
    List<Widget> CategoryTabsList =
        Hive.box<Category>('categories').values.toList().map((c) {
      return Tab(
        child: Text(
          c.categoryName,
          style: TextStyle(color: Color(c.categoryColor)),
        ),
      );
    }).toList();
    // CategoryBloc _categoryBloc = BlocProvider.value<CategoryBloc>(context);
    CategoryBloc _CategoryBloc = BlocProvider.of<CategoryBloc>(context);

    return DefaultTabController(
      length: CategoryTabsList.length,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Categories"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(30.0),
            child: TabBar(
                onTap: (index) {
                  _CategoryBloc.add(CategoryTabChanged(
                      name: categoriesList[index].categoryName));
                },
                isScrollable: true,
                controller: DefaultTabController.of(context),
                unselectedLabelColor: Colors.white.withOpacity(0.3),
                indicatorColor: Colors.white,
                tabs: CategoryTabsList),
          ),
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryTabLoaded) {
              return buildTransactionList(context, state.transactions);
            } else
              return Container();
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider<CategoryBloc>.value(
                            value: CategoryBloc(),
                            child: const Add_Category(),
                          )));
            }),
      ),
    );
  }
}

class Categories_List extends StatelessWidget {
  const Categories_List({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
        valueListenable: Hive.box<Category>('categories').listenable(),
        builder: (context, box, _) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: box.length,
              itemBuilder: (context, index) {
                Category c = box.getAt(index);
                return CategoryTile(
                  budget: c.budget,
                  categoryColor: c.categoryColor,
                  categoryDescription: c.categoryDescription,
                  categoryName: c.categoryName,
                );
              });
        });
  }
}

Widget buildTransactionList(
    BuildContext context, List<TransactionModel> transactionlist) {
  double moneyspent = 0;
  for (int i = 0; i < transactionlist.length; i++) {
    moneyspent += transactionlist[i].transactionAmount;
  }
  return Column(children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          height: 100,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(transactionlist.length.toString()),
                const Text("Transactions"),
              ],
            ),
          ),
        ),
        Container(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            Text("$moneyspent Rs/-"),
            const Text("Spent"),
          ]),
        )),
      ],
    ),
    const SizedBox(
      height: 10,
    ),
    ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: transactionlist.length,
        itemBuilder: (context, index) {
          TransactionModel transactionModel = transactionlist[index];
          return TransactionTile(
            transactionAmount: transactionModel.transactionAmount,
            transactionCategory: transactionModel.transactionCategory,
            transactionDate: transactionModel.transactionDate,
            transactionDescription: transactionModel.transactionDescription,
            transactionColor: transactionModel.transactionColor,
          );
        })
  ]);
}
