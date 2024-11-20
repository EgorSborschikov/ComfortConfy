import 'dart:convert';
import 'dart:developer';

import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/server/services/registration_service/user_create_model.dart';
import 'package:http/http.dart' as http;

Future<void> registerUser(UserCreateModel user) async {
  final response = await http.post(
    //Uri.parse('$API_BASE_URL/register'),
    Uri.parse('http://127.0.0.1:8000/register'),
    headers: {
      'Content-type': 'application/json',
    },
    body: 
    jsonEncode(user.toJson())
  );

  if (response.statusCode == 200){
    log('User create succsessful');
  } else {
    throw Exception('Registration error: ${response.body}');
  }
}