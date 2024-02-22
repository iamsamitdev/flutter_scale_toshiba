import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {

    // set flag ว่าเคยเข้ามาแล้ว
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('welcomeStatus', true);

    // ส่งไปหน้า login
    Navigator.pushReplacementNamed(context, AppRouter.login);
  }

  Widget _buildImage(String assetName, [double width = 250]) {
    return Image.asset('assets/images/intro/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 22.0, color: Colors.white);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: primary,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: primary,
      allowImplicitScrolling: true,
      // autoScrollDuration: 3000,
      infiniteAutoScroll: false,
      pages: [
        PageViewModel(
          title: "แนะนำระบบร้านค้าออนไลน์",
          body:"ระบบร้านค้าออนไลน์ สามารถใช้งานได้ทุกที่ทุกเวลา และสามารถเชื่อมต่อกับระบบบัญชีได้",
          image: _buildImage('s1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "ใช้งานง่าย ไม่ยุ่งยาก",
          body:
              "เหมาะสำหรับผู้ที่ไม่มีความรู้ด้านเทคโนโลยี สามารถใช้งานได้ง่าย ไม่ยุ่งยาก",
          image: _buildImage('s2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "เริ่มต้นใช้งานได้ทันที",
          body:
              "เริ่มต้นใช้งานได้ทันที ไม่ต้องรอนาน และไม่ต้องใช้เวลานานในการเรียนรู้การใช้งาน",
          image: _buildImage('s3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('ข้าม', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('เสร็จสิ้น', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}