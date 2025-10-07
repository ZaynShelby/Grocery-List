import 'package:flutter/material.dart';
import 'package:grocery_items/models/category.dart';

const categories = {
  Categories.category: Category('Select Category', Colors.black54),
  Categories.vegetables: Category('Vegetables', Colors.greenAccent),
  Categories.fruits: Category('Fruits', Colors.pinkAccent),
  Categories.spices: Category('Spices', Colors.orangeAccent),
  Categories.meats: Category('Meets', Colors.redAccent),
  Categories.sweets: Category('Sweets', Colors.purpleAccent),
  Categories.dairy: Category('Dairy', Colors.white),
  Categories.carbs: Category('Carbs', Colors.tealAccent),
  Categories.hygiene: Category('Hygiene', Colors.yellowAccent),
  Categories.convenience: Category('Convenience', Colors.deepPurpleAccent),
  Categories.others: Category('Others', Colors.cyanAccent),
};
