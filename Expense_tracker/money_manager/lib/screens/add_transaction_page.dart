import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/blocs/Category_bloc/category_bloc.dart';
import 'package:money_manager/blocs/transaction_bloc/transaction_bloc.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:intl/intl.dart';

var box = Hive.box<TransactionModel>('transactions');
var categorybox = Hive.box<Category>('categories');

class Add_Transaction extends StatefulWidget {
  const Add_Transaction({Key? key}) : super(key: key);

  @override
  _Add_TransactionState createState() => _Add_TransactionState();
}

class _Add_TransactionState extends State<Add_Transaction> {
  late double transactionAmount;
  String? transactionCategory;
  late String transactionDate = getCurrentDate(DateTime.now());
  late String transactionDescription;
  late int transactionColor;
  // String temp = "Select Category";
  // late int TransactionColor;
  // listCategories = [];
  final Categorycontroller = TextEditingController();
  final Amountcontroller = TextEditingController();
  final Descriptioncontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final item1 = categorybox.values
      .toList()
      .map(
        (e) => e.categoryName,
      )
      .toList();
  int temp1 = 1;
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
            value: transactionCategory,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            items: item1.map(buildMenuItem).toList(),
            onChanged: (value) => setState(() {
              transactionCategory = value.toString();
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

  Widget _buildAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: Amountcontroller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Amountcontroller.clear();
            },
          ),
          labelText: 'Money Spent',
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        // inputFormatters: FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),

        maxLength: 20,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          if (transactionCategory == null) {
            return 'Please select a category';
          }
        },
        onSaved: (value) {
          transactionAmount = double.parse(value!);
        },
      ),
    );
  }

  Widget _buildTransactionDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: Descriptioncontroller,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: 'Transaction Description',
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Descriptioncontroller.clear();
              },
            ),
            focusColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
        maxLength: 50,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Transaction Name is required';
          }
        },
        onSaved: (value) {
          transactionDescription = value.toString();
        },
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildtransactionDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: Descriptioncontroller,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: 'Transaction Description',
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Descriptioncontroller.clear();
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
          transactionDescription = value.toString();
        },
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate != null) {
      setState(() {
        transactionDate = getCurrentDate(newDate);
      });
    } else {
      setState(() {
        transactionDate = getCurrentDate(initialDate);
      });
    }
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
              const SizedBox(height: 30),
              _buildDropdownButton(),
              const SizedBox(height: 20),
              _buildAmount(),
              const SizedBox(height: 20),
              _buildTransactionDescription(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF11D8C5)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ))),
                  onPressed: () {
                    pickDate(context);
                  },
                  icon: const Icon(Icons.edit, color: Colors.black),
                  label: Text(
                    transactionDate.toString(),
                    style: const TextStyle(color: Colors.black),
                  )),
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
                    if (_formKey.currentState!.validate() &&
                        (transactionCategory != null)) {
                      _formKey.currentState!.save();
                      temp1 = 1;

                      BlocProvider.of<TransactionBloc>(context)
                          .add(AddTransaction(
                              transaction: TransactionModel(
                        transactionAmount: transactionAmount,
                        transactionCategory: transactionCategory.toString(),
                        transactionDate: transactionDate,
                        transactionDescription: transactionDescription,
                        transactionColor: const Color(0xFF29BF72).value,
                      )));

                      int date = int.parse(transactionDate.split('/')[0]);
                      int month = int.parse(transactionDate.split('/')[1]);

                      Navigator.pop(context, true);
                    } else if (transactionCategory == null) {
                      setState(() {
                        temp1 = -1;
                      });
                    }
                  })
            ])));
  }
}

getCurrentDate(var a) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String createDate = formatter.format(a);
  return createDate;
}
