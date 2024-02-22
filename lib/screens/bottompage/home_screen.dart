import 'package:flutter/material.dart';
import 'package:flutter_scale/app_router.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/constants.dart';

// สร้างตัวแปร refreshKey สำหรับการ RefreshIndicator
var refreshKey = GlobalKey<RefreshIndicatorState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: CallAPI().getAllProducts(), 
          builder: (context, AsyncSnapshot snapshot) {
            // กรณีที่มี error
            if(snapshot.hasError){
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if(snapshot.connectionState == ConnectionState.done){
              // กรณีที่โหลดข้อมูลสำเร็จ
              List<ProductModel> products = snapshot.data;
              return _listView(products);
            } else {
              // กรณีที่กำลังโหลดข้อมูล
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, AppRouter.productAdd);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // List View Widget
  Widget _listView(List<ProductModel> products){
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: SizedBox(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  AppRouter.productDetail,
                  arguments: {
                    'products': products[index].toJson(),
                  }
                );
              },
              child: Card (
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   products[index].image != null ? 
                    Container(
                      height: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        image: DecorationImage(
                          image: NetworkImage('$baseURLImage${products[index].image}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) 
                    : 
                    Image.asset(
                      'assets/images/noimg.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
                      child: Text('${products[index].name}', 
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
              
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price: ${products[index].price}', style: const TextStyle(fontSize: 16.0),),
                          Text('Stock: ${products[index].stock}', style: const TextStyle(fontSize: 16.0),),
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),
            )
          ),
        );
      }
    );
  }

}
