import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({super.key});

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  // Form prodcut add key
  final _formAddKey = GlobalKey<FormState>();

  // variable for product name
  String? _name,
      _description,
      _barcode,
      _stock,
      _price,
      _category_id,
      _user_id,
      status_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new product'),
      ),
      body: Form(
          key: _formAddKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                CustomTextField(
                  context,
                  'Name',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter name' : null,
                  (onSaved) => _name = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  'Description',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter description' : null,
                  (onSaved) => _description = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  'Barcode',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter barcode' : null,
                  (onSaved) => _barcode = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  'Stock',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter stock' : null,
                  (onSaved) => _stock = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  'Price',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter price' : null,
                  (onSaved) => _price = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: '1',
                  'Category ID',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter category id' : null,
                  (onSaved) => _category_id = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: '1',
                  'User ID',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter user id' : null,
                  (onSaved) => _user_id = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: '1',
                  'Status ID',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter status id' : null,
                  (onSaved) => status_id = onSaved,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formAddKey.currentState!.validate()) {
                      _formAddKey.currentState!.save();

                      // print('Name: $_name');
                      // print('Description: $_description');
                      // print('Barcode: $_barcode');
                      // print('Stock: $_stock');
                      // print('Price: $_price');
                      // print('Category ID: $_category_id');
                      // print('User ID: $_user_id');
                      // print('Status ID: $status_id');

                      // Add Product API
                      var response = await CallAPI().addProduct({
                        'name': _name,
                        'description': _description,
                        'barcode': _barcode,
                        'stock': _stock,
                        'price': _price,
                        'category_id': _category_id,
                        'user_id': _user_id,
                        'status_id': status_id,
                      });

                      var body = jsonDecode(response);

                      if (body['status'] == 'ok') {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(child: Text('Add product success'),),
                            ),
                          );
                          Navigator.pop(context);
                          refreshKey.currentState!.show();
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(child: Text('Add product failed'),),
                            ),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          )),
    );
  }
}
