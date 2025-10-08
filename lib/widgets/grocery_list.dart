import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_items/data/categories.dart';
import 'package:grocery_items/models/groceries.dart';
import 'package:grocery_items/widgets/new_items.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late List<GroceryItem> _groceryItems = [];
  var isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'flutter-grocery-54079-default-rtdb.firebaseio.com',
      'Groceries.json',
    );
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> _loadeditems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == item.value['category'],
          )
          .value;
      _loadeditems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          amount: item.value['amount'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = _loadeditems;
    });
  }

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
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: item.category.color,
        content: Text(
          'Item removed !',
          style: GoogleFonts.lexendDeca(color: Colors.black),
        ),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.black,
          onPressed: () {
            setState(() {
              _groceryItems.insert(index, item);
            });
          },
        ),
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

    if (isLoading) {
      content = Center(child: CircularProgressIndicator());
    }

    if (_groceryItems.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (context, index) => Dismissible(
            onDismissed: (duration) {
              _removeItems(_groceryItems[index]);
            },
            key: ValueKey(_groceryItems[index].id),
            child: Card(
              shape: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
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
                  style: GoogleFonts.inder(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Net: ${_groceryItems[index].quantity}',
                      style: GoogleFonts.notoSansDisplay(color: Colors.black),
                    ),
                    Text(
                      'Amt: ${_groceryItems[index].amount}',
                      style: GoogleFonts.notoSansDisplay(color: Colors.black),
                    ),
                  ],
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
