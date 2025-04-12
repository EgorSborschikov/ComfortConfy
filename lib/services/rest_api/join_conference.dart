import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';

Future<Map<String, dynamic>> joinConference(String roomId) async{
  final response = await http.get(Uri.parse('http://$baseUrl:8000/join_conference/${roomId}'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to join conference');
  }
}