import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config/api_cofing.dart';
import '../../../core/storage/token_storage.dart';

class AuthRepository {

  Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse("${ApiConfig.baseUrl}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }
}