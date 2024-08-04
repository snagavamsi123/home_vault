import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GenerateAccessToken {
  static Future<String> refreshToken() async {
    final storage = FlutterSecureStorage();
    String? refreshToken = await storage.read(key: 'refresh_token');

    final response = await http.post(
      Uri.parse(
          'https://1533-2402-8100-2575-6398-61c1-347e-8034-f153.ngrok-free.app/api/token/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'access_token', value: data['access']);
      await storage.write(key: 'username', value: data['name']);
      return 'success';
    } else {
      return 'failed';
      // Handle token refresh failure, possibly log the user out
    }
  }
}
