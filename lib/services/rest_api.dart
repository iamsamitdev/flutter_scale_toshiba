import 'dart:convert';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallAPI {

  // สร้างตัวแปรไว้เก็บ token
  static String _token = '';

  // สร้างฟังก์ชันอ่านข้อมูล token จาก SharedPreferences
  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token') ?? '';
  }

  // Set Headers
  _setHeaders() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Set Headers with Token
  _setHeadersWithToken() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $_token',
  };

  // ----------------------------------------
  // Auth API Call Method
  // ----------------------------------------

  // Register User API
  registerAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}auth/register'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // Login User API
  loginAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}auth/login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // ----------------------------------------
  // CRUD Product API Call Method
  // ----------------------------------------
  // Get All Products API
  Future<List<ProductModel>?> getAllProducts() async {
    await _getToken();
    final response = await http.get(
      Uri.parse('${baseURLAPI}products'),
      headers: _setHeadersWithToken(),
    );
    if(response.body.isNotEmpty){
      return productModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // Add Product API
  Future<String> addProduct(data) async {
    await _getToken();
    final response = await http.post(
      Uri.parse('${baseURLAPI}products'),
      body: jsonEncode(data),
      headers: _setHeadersWithToken(),
    );
    if(response.statusCode == 200){
      return response.body;
    }
    return '';
  }

  // Edit Product API
  Future<String> editProduct(int id, data) async {
    await _getToken();
    final response = await http.put(
      Uri.parse('${baseURLAPI}products/$id'),
      body: jsonEncode(data),
      headers: _setHeadersWithToken(),
    );
    if(response.statusCode == 200){
      return response.body;
    }
    return '';
  }

  // Delete Product API
  Future<String> deleteProduct(int id) async {
    await _getToken();
    final response = await http.delete(
      Uri.parse('${baseURLAPI}products/$id'),
      headers: _setHeadersWithToken(),
    );
    if(response.statusCode == 200){
      // logger.d(response.data);
      return response.body;
    }
    return '';
  }

}