import 'dart:convert';
import 'dart:developer';

import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/services/registration_service/user_create_model.dart';
import 'package:http/http.dart' as http;

Future<void> registerUser(UserCreateModel user) async {
  final response = await http.post(
    Uri.parse('$API_BASE_URL/register'),
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