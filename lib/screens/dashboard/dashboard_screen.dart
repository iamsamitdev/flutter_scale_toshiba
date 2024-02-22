import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/screens/bottompage/notification_screen.dart';
import 'package:flutter_scale/screens/bottompage/profile_screen.dart';
import 'package:flutter_scale/screens/bottompage/report_screen.dart';
import 'package:flutter_scale/screens/bottompage/setting_screen.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้างตัวแปรไว้เก็บ title ของแต่ละ screen
  String _title = 'Flutter Scale';

  // สร้างตัวแปรไว้เก็บ index ของ bottom navigation bar
  late int _currentIndex;

  // สร้าง List ของแต่ละหน้า
  final List<Widget> _children = [
    const HomeScreen(),
    const ReportScreen(),
    const NotificationScreen(),
    const SettingScreen(),
    const ProfileScreen()
  ];

  // สร้างฟังก์สำหรับเปลี่ยนหน้า
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = 'Home'; break;
        case 1: _title = 'Report'; break;
        case 2: _title = 'Notification'; break;
        case 3: _title = 'Setting'; break;
        case 4: _title = 'Profile'; break;
        default: _title = 'Flutter Scale'; break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  // ฟังก์ชันสำหรับ Logout
  _logout() async {
    // ลบค่า SharedPreferences ทั้งหมด
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogin');
    // prefs.clear();
    // ส่งไปหน้า Login
    Navigator.pushReplacementNamed(context, AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: const Text('Samit Koyom'),
                  accountEmail: const Text('samit@email.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        Image.asset('assets/images/samitavt.jpg').image,
                  ),
                ),
                ListTile(
                  title: const Text('Info'),
                  leading: const Icon(Icons.info),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  title: const Text('About'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  title: const Text('Contact'),
                  leading: const Icon(Icons.email),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    title: const Text('Logout'),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: _logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          onTabTapped(value);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
