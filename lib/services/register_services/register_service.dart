import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:comfort_confy/config.dart'; // Убедитесь, что путь к config.dart правильный

class RegisterService {
  final SupabaseClient _supabaseClient = SupabaseClient(
    supabaseUrl,
    supabaseKey,
  );

  Future<void> registerUser(String email, String password, String nickname) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'nickname': nickname},
      );

      if (response.user == null) {
        throw Exception('Registration failed: User is null');
      }
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
