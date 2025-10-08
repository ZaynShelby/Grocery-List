import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_items/data/categories.dart';
import 'package:grocery_items/models/category.dart';
import 'package:grocery_items/models/groceries.dart';
import 'package:http/http.dart' as http;

class NewItems extends StatefulWidget {
  const NewItems({super.key});
  @override
  State<NewItems> createState() => _NewItemsState();
}

class _NewItemsState extends State<NewItems> {
  var isSending = false;

  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = '';
  var _enteredAmount = 1;
  var _selectedCategory = categories[Categories.category]!;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isSending = true;
      });
      final url = Uri.https(
        'flutter-grocery-54079-default-rtdb.firebaseio.com',
        'Groceries.json',
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'Application/json'},
        body: json.encode({
          'name': _enteredName,
          'quantity': _enteredQuantity,
          'amount': _enteredAmount,
          'category': _selectedCategory.title,
        }),
      );
      final Map<String, dynamic> resData = json.decode(response.body);

      if (!mounted) return;

      Navigator.of(context).pop(
        GroceryItem(
          id: resData['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          amount: _enteredAmount,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 33,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      'Add a New Item',
                      style: GoogleFonts.notoSerif(
                        fontSize: 30,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                TextFormField(
                  style: GoogleFonts.encodeSans(color: Colors.white),
                  maxLength: 50,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length > 50 ||
                        value.trim().length < 2) {
                      return "Value must be length more than 2 and less than 50";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                      'Item Name',
                      style: GoogleFonts.inder(color: Colors.white54),
                    ),
                  ),
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Value must not be Empty";
                          }
                          final regex = RegExp(r'^[0-9]+');
                          if (!regex.hasMatch(value.trim())) {
                            return "Value must be Positive";
                          }
                          return null;
                        },
                        style: GoogleFonts.encodeSans(color: Colors.white),
                        decoration: InputDecoration(
                          hint: Text(
                            'e.g : 1 kg, g, dzn, ltr, pcs, pkt',
                            style: GoogleFonts.inder(color: Colors.lightGreen),
                          ),
                          label: Text(
                            'Quantity',
                            style: GoogleFonts.inder(color: Colors.white54),
                          ),
                        ),
                        onSaved: (value) {
                          _enteredQuantity = value!;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.parse(value) <= 0) {
                            return "Value must not Empty or -ve";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.numberWithOptions(),
                        style: GoogleFonts.encodeSans(color: Colors.white),
                        decoration: InputDecoration(
                          prefix: Text(
                            'Rs ',
                            style: GoogleFonts.inder(color: Colors.lightGreen),
                          ),
                          label: Text(
                            'Amount',
                            style: GoogleFonts.inder(color: Colors.white54),
                          ),
                        ),
                        onSaved: (value) {
                          _enteredAmount = int.parse(value!);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (_selectedCategory ==
                              categories[Categories.category]) {
                            return "Must choose a Category";
                          }
                          return null;
                        },
                        value: _selectedCategory,
                        dropdownColor: Colors.black87,
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: category.value.color,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    category.value.title,
                                    style: GoogleFonts.inder(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          _selectedCategory = value!;
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          isSending ? null : _formKey.currentState!.reset();
                        },
                        child: Text(
                          'Reset',
                          style: GoogleFonts.museoModerno(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                MaterialButton(
                  height: 50,
                  minWidth: 300,
                  onPressed: isSending ? null : _saveItem,
                  color: Colors.white70,
                  child: isSending
                      ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Save',
                          style: GoogleFonts.museoModerno(
                            fontSize: 25,
                            color: Colors.black87,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
