import 'package:grocery_items/models/category.dart';

class GroceryItem {
  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.amount,
    required this.category,
  });

  final String id;
  final String name;
  final String quantity;
  final int amount;
  final Category category;
}
