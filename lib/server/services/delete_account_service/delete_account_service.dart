import 'dart:convert';
import 'dart:developer';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;

class DeleteAccountService{
  Future<void> deleteUser(String email) async{
    final response = await http.delete(
      Uri.parse('$API_BASE_URL/delete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if(response.statusCode == 200){
      log('User delete successful');
    } else {
      throw Exception('Failed to delete user');
    }
  }
}