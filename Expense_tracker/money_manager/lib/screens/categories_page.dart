import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/blocs/Category_bloc/category_bloc.dart';
import 'package:money_manager/blocs/Transaction_bloc/transaction_bloc.dart';

import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/widgets/category_tile.dart';

import 'add_category_screen.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    print("hello3");

    // CategoryBloc _categoryBloc = BlocProvider.value<CategoryBloc>(context);
    CategoryBloc _CategoryBloc = BlocProvider.of<CategoryBloc>(context);
    // print("hello2");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: ValueListenableBuilder<Box>(
          valueListenable: Hive.box<Category>('categories').listenable(),
          builder: (context, box, _) {
            return ListView.builder(
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
          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<CategoryBloc>.value(
                      value: CategoryBloc(),
                      child: const Add_Category(),
                    )));
      }),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => MultiBlocProvider(
      //                 providers: <BlocProvider>[
      //                   BlocProvider.value(
      //                     value: BlocProvider.of<CategoryBloc>(context),
      //                   ),
      //                   BlocProvider.value(
      //                       value: BlocProvider.of<TransactionBloc>(context)),
      //                 ],
      //                 child: Add_Category(),
      //               )));
      // })
    );
  }
}
