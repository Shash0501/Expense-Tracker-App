import 'package:hive/hive.dart';
import 'package:money_manager/constants/default_categories.dart';
import 'package:money_manager/models/category_model.dart';

// ignore: non_constant_identifier_names
Future<void> add_default_categories(Box box) async {
  if (box.length == 0) {
    for (int i = 0; i < defaultCategories.length; i++) {
      box.add(defaultCategories[i]);
    }
  }
}

Future<void> add_category(Box box, Category c) async {
  box.add(c);
}
