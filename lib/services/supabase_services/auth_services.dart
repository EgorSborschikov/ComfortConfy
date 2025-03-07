import 'package:supabase_flutter/supabase_flutter.dart';

class AuthServices {
  final SupabaseClient _supabase = Supabase.instance.client; // create instans Supabase

  /// <Summary>
  /// SignIn with email & password
  /// </Summary>
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async{
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password
    );
  } 

  /// <Summary>
  /// SignUn with email & password
  /// </Summary>
  Future<AuthResponse> signUpWithEmailPassword(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password
    );
  }

  /// <Summary>
  /// SignOut
  /// </Summary>
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  /// <Summary>
  /// Get user email
  /// </Summary>
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }
}