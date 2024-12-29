import 'package:comfort_confy/services/registration_service/register_user.dart';
import 'package:comfort_confy/services/registration_service/user_create_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// ignore: prefer_const_constructors
final _storage = FlutterSecureStorage();

Future<void> registerAndSave(UserCreateModel user) async {
  final token = await registerUser(user);

  // Сохранение состояния пользователя и JWT
  await _storage.write(key: 'isRegistered', value: 'true');
  await _storage.write(key: 'jwtToken', value: token);
}

Future<bool> isUserRegistered() async {
  final isRegistered = await _storage.read(key: 'isRegistered');
  return isRegistered == 'true';
}

Future<String?> getJwtToken() async {
  return await _storage.read(key: 'jwtToken');
}