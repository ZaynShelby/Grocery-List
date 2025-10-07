import 'package:flutter/material.dart';

enum Categories {
  category,
  vegetables,
  fruits,
  meats,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  others,
}

class Category {
  const Category({
    required this.title,
    required this.color,
    required this.image,
  });

  final String title;
  final String image;
  final Color color;
}
