import 'dart:convert';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;

Future<void> deleteConference(String roomId) async {
  final response = await http.put(
    Uri.parse('http://$baseUrl:8000/delete_conference'),
    headers: {'Content-Type' : 'application/json'},
    body: jsonEncode(<String, String>{
      'room_id': roomId,
    }),
  );

  if (response.statusCode == 200){
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create conference');
  }
}