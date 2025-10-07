import 'package:flutter/material.dart';
import 'package:grocery_items/data/dummy_data.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: Colors.black54,
        backgroundColor: Colors.pink[700],
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.pink[700],
        centerTitle: true,
        title: Text(
          'Grocery',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              shape: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              tileColor: groceryItems[index].category.color,
              leading: Text(groceryItems[index].id),
              title: Text(groceryItems[index].name),
            ),
          ),
        ),
      ),
    );
  }
}
