import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class Utility {
  static Utility? utility;

  static Utility? getInstance() {
    utility ??= Utility();
    return utility;
  }

  // สร้างฟังก์ชันตรวจสอบการเชิือมต่อ Network
  Future<String> checkNetwork() async {
    // ตรวจสอบการเชื่อมต่อ Network
    var checkNetwork = await Connectivity().checkConnectivity();

    if (checkNetwork == ConnectivityResult.mobile) {
      return 'mobile';
    } else if (checkNetwork == ConnectivityResult.wifi) {
      return 'wifi';
    } else if (checkNetwork == ConnectivityResult.ethernet) {
      return 'ethernet';
    } else if (checkNetwork == ConnectivityResult.none) {
      return 'none';
    } else {
      return 'none';
    }
  }

  // Alert Dialog แจ้งเตือนเมื่อไม่มีการเชื่อมต่อ Internet
  static showAlertDialog(context, title, content) {
    AlertDialog buildAlertDialog(Color backgroundColor, IconData icon) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Center(
          child: Text(title),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 35,
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(content),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ปิด')),
        ],
      );
    }

    switch (title) {
      case "มีข้อผิดพลาด":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
            heightFactor: 0.4,
            child: buildAlertDialog(Colors.red[700]!, Icons.close),
          ),
        );
      case "สำเร็จ":
        return showDialog(
          context: context,
          builder: (BuildContext context) => FractionallySizedBox(
            heightFactor: 0.4,
            child: buildAlertDialog(Colors.green[700]!, Icons.check),
          ),
        );
    }
  }
}
