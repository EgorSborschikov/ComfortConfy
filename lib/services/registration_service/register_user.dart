import 'dart:convert';
import 'dart:developer';

import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/services/registration_service/user_create_model.dart';
import 'package:http/http.dart' as http;

Future<String> registerUser(UserCreateModel user) async {
  final response = await http.post(
    Uri.parse('$API_BASE_URL/register'),
    headers: {
      'Content-type': 'application/json',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final token = data['token'];
    log('User created successfully');
    return token;
  } else {
    final errorMessage = jsonDecode(response.body)['detail'];
    throw Exception('Registration error: $errorMessage');
  }
}