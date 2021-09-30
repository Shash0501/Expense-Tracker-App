import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/blocs/Category_bloc/category_bloc.dart';
import 'package:money_manager/models/category_model.dart';

import 'categories_page.dart';

var box = Hive.box<Category>('categories');

class Add_Category extends StatefulWidget {
  const Add_Category({Key? key}) : super(key: key);

  @override
  _Add_CategoryState createState() => _Add_CategoryState();
}

class _Add_CategoryState extends State<Add_Category> {
  late String categoryName;
  late String categoryDescription;
  late double budget;
  // late int categoryColor;
  final namecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final budgetcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: namecontroller,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                namecontroller.clear();
              },
            ),
            labelText: 'Category Name',
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
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
        onSaved: (value) {
          categoryName = value.toString();
        },
      ),
    );
  }

  Widget _buildBudget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: budgetcontroller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              budgetcontroller.clear();
            },
          ),
          labelText: 'Budget',
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        // inputFormatters: FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

        maxLength: 20,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Budget is required';
          }
        },
        onSaved: (value) {
          budget = double.parse(value!);
        },
      ),
    );
  }

  Widget _buildcategoryDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: descriptioncontroller,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: 'Category Description',
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                descriptioncontroller.clear();
              },
            ),
            focusColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        maxLength: 50,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Category Name is required';
          }
        },
        onSaved: (value) {
          categoryDescription = value.toString();
        },
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Category'),
        ),
        body: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              const SizedBox(height: 20),
              _buildName(),
              const SizedBox(height: 20),
              _buildBudget(),
              const SizedBox(height: 20),
              _buildcategoryDescription(),
              const SizedBox(height: 20),
              ElevatedButton(
                  child: const Text(
                    'Add Category',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF11D8C5)),
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(200, 50)),
                      shadowColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF86EBE1))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // box.add(Category(
                      //     categoryName: categoryName,
                      //     categoryDescription: categoryDescription,
                      //     budget: budget,
                      //     categoryColor: Color(0xFF0C5851).value));
                      BlocProvider.of<CategoryBloc>(context).add(AddCategory(
                          category: Category(
                              categoryName: categoryName,
                              categoryDescription: categoryDescription,
                              budget: budget,
                              categoryColor: const Color(0xFFF4ED1C).value),
                          box: box));
                      // print(categoryName);
                      // print(budget);
                      // print(categoryDescription);

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                  value: CategoryBloc(),
                                  child: CategoriesPage())));
                    }
                  })
            ])));
  }
}
