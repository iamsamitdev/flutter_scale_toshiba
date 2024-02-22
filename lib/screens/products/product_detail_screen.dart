import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/screens/bottompage/home_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // รับค่าที่ส่งมาจากหน้า home_screen.dart
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      // backgroundColor: Colors.red,
      // appBar: AppBar(
      // backgroundColor: const Color(0x44000000),
      //   elevation: 100,
      // ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: arguments['products']['image'] != null
                        ? NetworkImage(
                            baseURLImage + arguments['products']['image'])
                        : const AssetImage('assets/images/noimg.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${arguments['products']['name']}',
                  style: const TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: ${arguments['products']['price']}',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      'Stock: ${arguments['products']['stock']}',
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  '${arguments['products']['description']}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRouter.productEdit,
                      arguments: {
                        'products': arguments['products'],
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 30.0,
                    color: Colors.amber,
                  ),
                ),
                const Text('Edit'),
                const SizedBox(
                  width: 20.0,
                ),
                IconButton(
                  onPressed: () {
                    // แสดง Alert Confirm Dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Delete'),
                          content: const Text(
                              'Are you sure you want to delete this item?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel')),
                            TextButton(
                              onPressed: () async {
                                // ทำการลบข้อมูล
                                var response = await CallAPI()
                                    .deleteProduct(arguments['products']['id']);

                                var body = jsonDecode(response);

                                // ถ้าลบสำเร็จ
                                if (body['status'] == 'ok') {
                                  // และปิด Alert Confirm Dialog
                                  Navigator.pop(context);
                                  // และปิดหน้านี้
                                  Navigator.pop(context);
                                  // refresh หน้า home_screen.dart
                                  refreshKey.currentState!.show();
                                }
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 30.0,
                    color: Colors.red,
                  ),
                ),
                const Text('Delete'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
