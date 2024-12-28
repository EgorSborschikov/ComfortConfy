import 'package:comfort_confy/services/registration_service/register_user.dart';
import 'package:comfort_confy/services/registration_service/user_create_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> registerAndSave(UserCreateModel user) async {
  final token = await registerUser(user);

  // Сохранение состояния пользователя и JWT
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isRegistered', true);
  await prefs.setString('jwtToken', token);
}

Future<bool> isUserRegistered() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isRegistered') ?? false;
}

Future<String?> getJwtToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwtToken');
}