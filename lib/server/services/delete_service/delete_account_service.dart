import 'dart:convert';
import 'package:comfort_confy/config.dart';
import 'package:http/http.dart' as http;
import 'user_delete_model.dart';

Future<void> deleteAccount(UserDeleteModel user) async {
  final url = Uri.parse('$API_BASE_URL/delete');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode(user.toJson());

  final response = await http.delete(
    url,
    headers: headers,
    body: body,
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to delete account: ${response.statusCode}');
  }
}
