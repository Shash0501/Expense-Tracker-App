import 'package:flutter/cupertino.dart';
import 'package:money_manager/models/category_model.dart';

List<Category> defaultCategories = [
  Category(
      categoryName: "Food",
      categoryColor: const Color(0xFF0CDFBF).value,
      budget: 2500.0,
      categoryDescription: "Money spent on food items"),
  Category(
      categoryName: "Bills",
      categoryColor: const Color(0xFFDB3A7D).value,
      budget: 3000.0,
      categoryDescription: "Bill payments"),
  Category(
      categoryName: "Other",
      categoryColor: const Color(0xFFE27554).value,
      budget: 1000.0,
      categoryDescription: "Miscellaneous expenses"),
];
