import 'package:supabase_flutter/supabase_flutter.dart';

Future<bool> isUserRegistered() async {
  final response = await Supabase.instance.client.auth.currentSession;
  print('Session: $response');
  return response != null;
}

Future<bool> isUserLoggedIn() async {
  final user = Supabase.instance.client.auth.currentUser;
  print('Session: $user');
  return user != null;
}
