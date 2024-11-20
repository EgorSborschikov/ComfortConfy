import 'package:comfort_confy/server/services/registration_service/register_user.dart';
import 'package:comfort_confy/server/services/registration_service/user_create_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> registerAndSave(UserCreateModel user) async {
  await registerUser(user);
  
  // Сохранение состояния пользователя
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isRegistered', true);
}