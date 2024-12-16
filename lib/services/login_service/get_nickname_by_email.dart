import '../../config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> getNicknameByEmail(String email) async {
  final url = Uri.parse('$API_BASE_URL/get_nickname');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['nickname'];
  } else {
    throw Exception('Failed to get nickname');
  }
}