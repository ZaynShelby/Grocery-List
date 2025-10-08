import 'package:flutter/material.dart';
import 'package:grocery_items/models/category.dart';

const categories = {
  Categories.category: Category(
    title: 'Select Category',
    color: Colors.black54,
    image: 'lib/images/category.png',
  ),
  Categories.vegetables: Category(
    title: 'Vegetables',
    color: Colors.greenAccent,
    image: 'lib/images/vegetable.png',
  ),
  Categories.fruits: Category(
    title: 'Fruits',
    color: Colors.pinkAccent,
    image: 'lib/images/fruit.png',
  ),
  Categories.spices: Category(
    title: 'Spices',
    color: Colors.orangeAccent,
    image: 'lib/images/spices.png',
  ),
  Categories.meats: Category(
    title: 'Meats',
    color: Colors.redAccent,
    image: 'lib/images/meats.png',
  ),
  Categories.sweets: Category(
    title: 'Sweets',
    color: Colors.purpleAccent,
    image: 'lib/images/sweets.png',
  ),
  Categories.dairy: Category(
    title: 'Dairy',
    color: Colors.white,
    image: 'lib/images/dairy.png',
  ),
  Categories.carbs: Category(
    title: 'Carbs',
    color: Colors.tealAccent,
    image: 'lib/images/carbs.png',
  ),
  Categories.hygiene: Category(
    title: 'Hygiene',
    color: Colors.yellowAccent,
    image: 'lib/images/hygiene.png',
  ),
  Categories.convenience: Category(
    title: 'Convenience',
    color: Colors.deepPurpleAccent,
    image: 'lib/images/convenience.png',
  ),
  Categories.others: Category(
    title: 'Others',
    color: Colors.cyanAccent,
    image: 'lib/images/other_grocery.png',
  ),
};
