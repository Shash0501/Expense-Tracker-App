import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category_model.dart';

var box = Hive.box<Category>('categories');

// ignore: unused_element
Widget _buildName() {
  return TextFormField(
    decoration: const InputDecoration(
      labelText: 'Category Name',
    ),
    maxLength: 20,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Category Name is required';
      }

      for (int i = 0; i < box.length; i++) {
        if (box.getAt(i)!.categoryName == value) {
          return 'Category Name already exists';
        }
      }
    },
    onSaved: (value) {},
  );
}

// ignore: unused_element
Widget _buildBudget() {
  return TextFormField(
    decoration: const InputDecoration(
      labelText: 'Category Name',
    ),
    maxLength: 20,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Category Name is required';
      }

      for (int i = 0; i < box.length; i++) {
        if (box.getAt(i)!.categoryName == value) {
          return 'Category Name already exists';
        }
      }
    },
    onSaved: (value) {},
  );
}

// ignore: unused_element
Widget _buildcategoryDescription() {
  return TextFormField(
    decoration: const InputDecoration(
      labelText: 'Category Name',
    ),
    maxLength: 20,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Category Name is required';
      }

      for (int i = 0; i < box.length; i++) {
        if (box.getAt(i)!.categoryName == value) {
          return 'Category Name already exists';
        }
      }
    },
    onSaved: (value) {},
  );
}
