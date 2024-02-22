import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({super.key});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  // Form prodcut add key
  final _formEditKey = GlobalKey<FormState>();

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
    // รับค่าที่ส่งมาจากหน้า product_detail_screen.dart
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    print(arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text('${arguments['products']['name']}'),
      ),
      body: Form(
          key: _formEditKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                CustomTextField(
                  context,
                  initialValue: arguments['products']['name'],
                  'Name',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter name' : null,
                  (onSaved) => _name = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['description'],
                  'Description',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter description' : null,
                  (onSaved) => _description = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['barcode'],
                  'Barcode',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter barcode' : null,
                  (onSaved) => _barcode = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['stock'].toString(),
                  'Stock',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter stock' : null,
                  (onSaved) => _stock = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['price'].toString(),
                  'Price',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter price' : null,
                  (onSaved) => _price = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['category_id'].toString(),
                  'Category ID',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter category id' : null,
                  (onSaved) => _category_id = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['user_id'].toString(),
                  'User ID',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter user id' : null,
                  (onSaved) => _user_id = onSaved,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  context,
                  initialValue: arguments['products']['status_id'].toString(),
                  'Status ID',
                  (onValidate) =>
                      onValidate.isEmpty ? 'Please enter status id' : null,
                  (onSaved) => status_id = onSaved,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formEditKey.currentState!.validate()) {
                      _formEditKey.currentState!.save();

                      // print('Name: $_name');
                      // print('Description: $_description');
                      // print('Barcode: $_barcode');
                      // print('Stock: $_stock');
                      // print('Price: $_price');
                      // print('Category ID: $_category_id');
                      // print('User ID: $_user_id');
                      // print('Status ID: $status_id');

                      // Add Product API
                      var response = await CallAPI()
                          .editProduct(arguments['products']['id'], {
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
                              content: Center(
                                child: Text('Edit product success'),
                              ),
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                          refreshKey.currentState!.show();
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text('Edit product failed'),
                              ),
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
                  child: const Text('Update'),
                ),
              ],
            ),
          )),
    );
  }
}
