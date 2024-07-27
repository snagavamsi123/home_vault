import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GenerateAccessToken {
  static Future<String> refreshToken() async {
    final storage = FlutterSecureStorage();
    String? refreshToken = await storage.read(key: 'refresh_token');

    final response = await http.post(
      Uri.parse(
          'https://b6d9-115-98-217-224.ngrok-free.app/api/token/refresh/'),
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
