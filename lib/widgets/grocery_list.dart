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
  void _addItems() async {
    final newItem = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NewItems(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItems(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item removed !'),
        action: SnackBarAction(label: 'Undo', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No Items added Yet !',
        style: GoogleFonts.notoSerif(fontSize: 20, color: Colors.white54),
      ),
    );

    if (_groceryItems.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Dismissible(
              onDismissed: (duration) {
                _removeItems(_groceryItems[index]);
              },
              key: ValueKey(_groceryItems[index].id),
              child: ListTile(
                shape: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                tileColor: _groceryItems[index].category.color,
                leading: Image.asset(
                  _groceryItems[index].category.image,
                  height: 30,
                  width: 30,
                ),
                title: Text(
                  _groceryItems[index].name,
                  style: GoogleFonts.encodeSans(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addItems,
        foregroundColor: Colors.black54,
        backgroundColor: Colors.white70,
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        centerTitle: false,
        title: Text(
          'Grocery',
          style: GoogleFonts.emblemaOne(color: Colors.white, fontSize: 30),
        ),
      ),
      body: content,
    );
  }
}
