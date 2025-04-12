import 'dart:convert';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;

Future<void> updateConferenceName(String roomId, String newName) async {
  final response = await http.put(
    Uri.parse('http://$baseUrl:8000/update_conference_name'),
    headers: {'Content-Type' : 'application/json'},
    body: jsonEncode(<String, String>{
      'room_id': roomId,
      'new_name': newName,
    }),
  );

  if (response.statusCode == 200){
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create conference');
  }
}