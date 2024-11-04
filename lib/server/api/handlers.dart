import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:bcrypt/bcrypt.dart';
import 'database.dart';

class User {
  final String username;
  final String password;
  final String email;

  User({required this.username, required this.password, required this.email});

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'email': email,
  };
}

Future<Response> registerHandler(Request request, Database db) async {
  try {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    final user = User(
      username: data['username'],
      password: data['password'],
      email: data['email'],
    );

    final hashedPassword = BCrypt.hashpw(user.password, BCrypt.gensalt());

    // Вставка нового пользователя в базу данных
    await db.connection.query(
      'INSERT INTO users ("IDUser ", "IDStatusActivity", "User Name", "Email(Login)", "PasswordHash") VALUES (DEFAULT, 1, @username, @email, @password)',
      substitutionValues: {
        'username': user.username,
        'email': user.email,
        'password': hashedPassword,
      },
    );

    return Response.ok(jsonEncode({'message': 'User  registered successfully'}), headers: {'Content-Type': 'application/json'});
  } catch (e) {
    return Response.internalServerError(body: 'Error registering user: $e');
  }
}

Future<Response> loginHandler(Request request, Database db) async {
  try {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    final username = data['username'];
    final password = data['password'];

    final result = await db.connection.query(
      'SELECT "PasswordHash" FROM users WHERE "User Name" = @username',
      substitutionValues: {'username': username},
    );

    if (result.isEmpty) {
      return Response.forbidden('Invalid username or password');
    }

    final storedPassword = result.first[0] as String;

    if (!BCrypt.checkpw(password, storedPassword)) {
      return Response.forbidden('Invalid username or password');
    }

    return Response.ok(jsonEncode({'message': 'Login successful'}), headers: {'Content-Type': 'application/json'});
  } catch (e) {
    return Response.internalServerError(body: 'Error logging in: $e');
  }
}