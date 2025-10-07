import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_items/models/groceries.dart';
import 'package:grocery_items/widgets/new_items.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  void _addItems() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NewItems(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
      // MaterialPageRoute(builder: (ctx) => NewItems()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addItems,
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
          itemCount: _groceryItems.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              shape: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              tileColor: _groceryItems[index].category.color,
              leading: Text(_groceryItems[index].id),
              title: Text(
                _groceryItems[index].name,
                style: GoogleFonts.encodeSans(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
