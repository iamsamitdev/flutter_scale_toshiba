// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

Widget CustomTextField(
  BuildContext context,
  String hintText, 
  Function onValidate,
  Function onSaved,
  {
    FocusNode? focusNode,
    String initialValue = '',
    Icon? icon,
    bool obscureText = false,
    var keyboardType = TextInputType.text,
  }
) {
  return TextFormField(
    focusNode: focusNode,
    initialValue: initialValue,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: hintText,
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.teal,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2,
        ),
      ),
    ),
    validator: (value) => onValidate(value.toString().trim()),
    onSaved: (value) => onSaved(value.toString().trim()),
  );
}
