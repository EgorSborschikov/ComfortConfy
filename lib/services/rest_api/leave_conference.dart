import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';

Future<Map<String, dynamic>> leaveConference(String roomId) async {
  final response = await http.post(Uri.parse('$baseUrl:8000/leave_conference/$roomId'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to leave conference');
  }
}