// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // สร้าง key สำหรับ form
  final GlobalKey<FormState> _formKeyLogin = GlobalKey();

  // สร้างตัวแปรไว้เก็บค่า email และ password
  late String _email, _password;

  // focus node สำหรับเปลี่ยน focus ไปยังช่องอื่น
  final usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKeyLogin,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 180),
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
                          initialValue: 'samit@email.com',
                          'Email',
                          (onValidate) =>
                              onValidate.isEmpty ? 'Please enter email' : null,
                          (onSaved) => _email = onSaved,
                          focusNode: usernameFocusNode),
                      SizedBox(height: 20),
                      CustomTextField(
                        context,
                        initialValue: '123456',
                        'Password',
                        (onValidate) =>
                            onValidate.isEmpty ? 'Please enter password' : null,
                        (onSaved) => _password = onSaved,
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // เช็คการ submit form ถ้าไม่ผ่านจะไม่ทำการ login
                          if (_formKeyLogin.currentState!.validate()) {
                            // ทำการ save form
                            _formKeyLogin.currentState!.save();

                            // print('Email: $_email');
                            // print('Password: $_password');

                            // Check ว่ามีการเชื่อมต่อ Internet หรือไม่
                            if(await Utility.getInstance()!.checkNetwork() == 'none') {
                              Utility.showAlertDialog(
                                context, 'มีข้อผิดพลาด', 'ไม่มีการเชื่อมต่อ Internet'
                              );
                              return;     
                            }
                            // API Login
                            var response = await CallAPI().loginAPI(
                                {"email": _email, "password": _password});

                            // แสดงข้อมูลที่ได้จากการ login
                            var body = jsonDecode(response.body);

                            // ทำการเปลี่ยนหน้าไปยังหน้า Dashboard
                            if (body['status'] == 'ok') {
                                 
                              // บันทึกข้อมูลลงใน SharedPreferences
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              prefs.setString('token', body['token']);
                              prefs.setString('email', _email);
                              prefs.setString('name', body['user']['firstname']);
                              prefs.setString('lastname', body['user']['lastname']);

                              // flag for check user is login
                              prefs.setBool('isLogin', true);

                              if (context.mounted) {
                                Navigator.pushReplacementNamed(context, AppRouter.dashboard);
                              }
                            } else {
                              if (context.mounted) {
                                // แจ้งเตือนเมื่อ username หรือ password ไม่ถูกต้อง
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child:
                                          Text('ข้อมูลเข้าสู่ระบบไม่ถูกต้อง'),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                // Reset form
                                _formKeyLogin.currentState!.reset();
                                // Focus ไปที่ช่อง Username ใหม่
                                usernameFocusNode.requestFocus();
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
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ยังไม่เป็นสมาชิก ?'),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRouter.register);
                              },
                              child: const Text('สมัครสมาชิก')),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
