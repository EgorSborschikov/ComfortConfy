import 'package:comfort_confy/server/services/login_services/login_user.dart';
import 'package:comfort_confy/server/services/login_services/user_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginAndSave(UserAuthModel user) async {
  await loginUsers(user);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLogined', true);
}

Future<bool> isUserLogined() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLogined') ?? false;
}