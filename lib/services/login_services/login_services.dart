import 'package:comfort_confy/config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginService {
  final SupabaseClient _supabaseClient = SupabaseClient(
    supabaseUrl, 
    supabaseKey
  );
  Future<void> registerUser(String email, String password, String nickname) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {'nickname': nickname},
    );

    if (response.user == null) {
      throw Exception('Log in failed: User not found');
    }

    // После успешной регистрации, вы можете перенаправить пользователя на страницу входа или домашнюю страницу
  }

  /*Future<void> logoutUser() async {
    try {
      final response = await _supabaseClient.auth.signOut();

      if (response.user == null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }*/
}