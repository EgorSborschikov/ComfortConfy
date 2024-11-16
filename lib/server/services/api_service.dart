import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:comfort_confy/config.dart';  
class ApiService {
  Future<http.Response> registerUser(String nickname, String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/register'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': nickname,
        'email': email,
        'password': password,
      }),
    );

    return response;
  }

  Future<http.Response> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_BASE_URL/login'), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    return response;
  }
}
