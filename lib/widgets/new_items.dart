import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_items/data/categories.dart';
import 'package:grocery_items/models/category.dart';

class NewItems extends StatefulWidget {
  const NewItems({super.key});
  @override
  State<NewItems> createState() => _NewItemsState();
}

class _NewItemsState extends State<NewItems> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = '';
  var _enteredAmount = 1;
  var _selectedCategory = categories[Categories.category]!;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_enteredName);
      print(_enteredQuantity);
      print(_enteredAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 100),
          child: SingleChildScrollView(
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
                        value.trim().length >= 50 ||
                        value.trim().length <= 1) {
                      return "Value must be length more than 1 and less than 50";
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
                            '1 kg, g, dzn, ltr, pcs, pkt',
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
                          _formKey.currentState!.reset();
                        },
                        child: Text('Reset', style: GoogleFonts.museoModerno()),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                MaterialButton(
                  height: 50,
                  minWidth: 300,
                  onPressed: _saveItem,
                  color: Colors.white70,
                  child: Text(
                    'Save',
                    style: GoogleFonts.museoModerno(fontSize: 25),
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
