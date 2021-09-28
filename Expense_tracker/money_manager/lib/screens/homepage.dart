import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/widgets/category_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
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
            }));
  }
}
