import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // อ่านข้อมูล profile จาก shared preference --------------------------------------
  String? _firstName, _lastName, _email;

  // สร้างฟังก์ชัน getUserProfile สำหรับอ่านข้อมูลจาก shared preference
  getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstName = prefs.getString('name');
    var lastName = prefs.getString('lastname');
    var email = prefs.getString('email');

    setState(() {
      _firstName = firstName;
      _lastName = lastName;
      _email = email;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }
  // ---------------------------------------------------------------------------

  // Method Logout -----------------------------------------------------------
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('isLogin');
    Navigator.pushReplacementNamed(context, AppRouter.login);

    // Clear all route and push to login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          _buildHeader(),
          _buildListMenu(),
        ],
      ),
    );
  }

  // สร้าง widget สำหรับแสดงข้อมูล profile ที่อ่านมาจาก shared preference
  Widget _buildHeader() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: primaryDark,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/noavartar.png'),
          ),
          const SizedBox(height: 10),
          Text(
            '$_firstName $_lastName',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '$_email',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // สร้าง widget สำหรับแสดงรายการเมนูต่างๆ
  Widget _buildListMenu() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.password),
          title: const Text('Change Password'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Change Language'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Setting'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Logout'),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: logout,
        ),
      ],
    );
  }
}
