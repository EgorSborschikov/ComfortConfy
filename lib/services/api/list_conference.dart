import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config.dart';

Future<List<dynamic>> searchConferences(String query) async {
  final response = await http.get(Uri.parse('$baseUrl/list_conferences'));

  if (response.statusCode == 200) {
      List<dynamic> conferences = jsonDecode(response.body);

      // Фильтрация конференций по запросу
      if (query.isNotEmpty) {
        conferences = conferences.where((conference) {
          final name = conference['name'].toLowerCase();
          final link = conference['link'].toLowerCase();
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || link.contains(searchQuery);
        }).toList();
      }

    return conferences;
  } else {
    throw Exception('Failed to load conferences');
  }
}