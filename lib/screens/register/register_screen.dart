// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/services/rest_api.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // สร้าง key สำหรับ form
  final GlobalKey<FormState> _formKeyRegister = GlobalKey();

  // สร้างตัวแปรไว้เก็บค่า firstname, lastname, email, username และ password
  late String _firstname, _lastname, _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKeyRegister,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Center(
                child: Image.asset(
                  'assets/images/toshibalogo.png',
                  width: 200,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    CustomTextField(
                      context, 
                      'Firstname',
                      (onValidate) => onValidate.isEmpty ? 'Please enter firstname' : null,
                      (onSaved) => _firstname = onSaved,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      context, 
                      'Lastname',
                      (onValidate) => onValidate.isEmpty ? 'Please enter lastname' : null,
                      (onSaved) => _lastname = onSaved,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      context, 
                      'Email',
                      (onValidate) => onValidate.isEmpty ? 'Please enter email' : null,
                      (onSaved) => _email = onSaved,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      context, 
                      'Password',
                      (onValidate) => onValidate.isEmpty ? 'Please enter password' : null,
                      (onSaved) => _password = onSaved,
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // เช็คการ submit form ถ้าไม่ผ่านจะไม่ทำการ login
                        if(_formKeyRegister.currentState!.validate()) {
                          // ทำการ save form
                          _formKeyRegister.currentState!.save();

                          // print('Firstname: $_firstname');
                          // print('Lastname: $_lastname');
                          // print('Email: $_email');
                          // print('Password: $_password');

                          // API Register
                          var response = await CallAPI().registerAPI(
                            {
                              'firstname': _firstname,
                              'lastname': _lastname,
                              'email': _email,
                              'password': _password,
                            }
                          );

                          var body = jsonDecode(response.body);

                          // print(body);
                          if(body['status'] == 'ok'){
                            if(context.mounted) {
                              // แสดง message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text(body['message'])),
                                  backgroundColor: Colors.green,
                                )
                              );
                              // ทำการเปลี่ยนไปหน้า login
                              Navigator.pop(context);
                            }
                          } else {
                            if(context.mounted) {
                              // แสดง message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text(body['message'])),
                                  backgroundColor: Colors.red,
                                )
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
                      child: Text('Register', style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('เป็นสมาชิกอยู่แล้ว ?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text('เข้าสู่ระบบ')
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}