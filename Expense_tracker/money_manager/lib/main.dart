import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/screens/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/services/category_services.dart';
import 'models/category_model.dart';
import 'models/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Category>('categories');
  await Hive.openBox<TransactionModel>('transactions');
  Box categories = Hive.box<Category>('categories');
  // await add_default_categories(categories);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
