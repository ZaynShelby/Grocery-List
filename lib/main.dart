import 'package:flutter/material.dart';
import 'package:grocery_items/widgets/grocery_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GroceryList());
  }
}
