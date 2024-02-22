import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

dynamic initRoute;

void main() async {

  // ต้องเรียกใช้ WidgetsFlutterBinding.ensureInitialized()
  // เพื่อให้สามารถเรียกใช้ SharedPreferences ได้
  WidgetsFlutterBinding.ensureInitialized();

  // สร้างตัวแปร prefs ไว้เก็บค่า SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // ตรวจสอบว่าเคยผ่านหน้า Welcome หรือยัง
  if(prefs.getBool('welcomeStatus') == true) {
    initRoute = AppRouter.login;
    // ตรวจสอบผ่านหน้า Login หรือยัง
    if(prefs.getBool('isLogin') == true) {
      initRoute = AppRouter.dashboard;
    }
  } else {
    initRoute = AppRouter.welcome;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initRoute,
      routes: AppRouter.routes,
    );
  }
}