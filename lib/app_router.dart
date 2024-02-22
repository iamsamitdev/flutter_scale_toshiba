import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawerpage/about_screen.dart';
import 'package:flutter_scale/screens/drawerpage/contact_screen.dart';
import 'package:flutter_scale/screens/drawerpage/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/products/product_add_screen.dart';
import 'package:flutter_scale/screens/products/product_detail_screen.dart';
import 'package:flutter_scale/screens/products/product_edit_screen.dart';
import 'package:flutter_scale/screens/register/register_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

class AppRouter {

  // Router Map Key
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String dashboard = 'dashboard';
  static const String info = 'info';
  static const String about = 'about';
  static const String contact = 'contact';
  static const String productDetail = 'productDetail';
  static const String productAdd = 'productAdd';
  static const String productEdit = 'productEdit';

  // Router Map
  static get routes => {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    dashboard: (context) => const DashboardScreen(),
    info: (context) => const InfoScreen(),
    about: (context) => const AboutScreen(),
    contact: (context) => const ContactScreen(),
    productDetail: (context) => const ProductDetailScreen(),
    productAdd: (context) => const ProductAddScreen(),
    productEdit: (context) => const ProductEditScreen(),
  };

}