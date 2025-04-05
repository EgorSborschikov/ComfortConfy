import 'dart:convert';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> createConference(Map<String, dynamic> conferenceData) async {
  final response = await http.post(
    Uri.parse('$baseUrl/create_conference'),
    headers: {'Content-Type' : 'application/json'},
    body: jsonEncode(conferenceData)
  );

  if (response.statusCode == 200){
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create conference');
  }
}