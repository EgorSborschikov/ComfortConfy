import 'dart:convert';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;

late String email;
late String password;

Future<void> deleteAccount(String email, password) async {
  final response = await http.delete(
    Uri.parse('$API_BASE_URL/delete?email = $email?password = $password')
  );

  if(response.statusCode == 200){
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to delete account');
  }
}