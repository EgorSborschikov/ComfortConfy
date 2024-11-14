import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://37.139.41.47:5432";

  Future<bool> registerUser(String username, String password, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'email': email,
      }),
    );

    return response.statusCode == 201; // 201 Created
  }
}
