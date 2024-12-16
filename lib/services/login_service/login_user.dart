import 'dart:convert';
import 'dart:developer';

import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/services/login_service/user_auth_model.dart';
import 'package:http/http.dart' as http;

Future<void> loginUsers(UserAuthModel user) async{
  final response = await http.post(
    Uri.parse('$API_BASE_URL/login'),
    headers: {
      'Content-type': 'application/json',
    },
    body: 
    jsonEncode(user.toJson())
  );

  if (response.statusCode == 200){
    log('User login succsessful');
  } else {
    throw Exception('Registration error: ${response.body}');
  }
}