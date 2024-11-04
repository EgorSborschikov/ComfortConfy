import 'package:comfort_confy/server/api/database.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:bcrypt/bcrypt.dart';

class User{
  final String username;
  final String email;
  final String password;

  User({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'ogin': email,
    'password': password,
  };
}
Future<Response> registerHandler(Request request, Database, database) async{
  try{
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    final user = User(
      username: data['username'], 
      email: data['email'], 
      password: data['password'],
    );

    final hashedPassword = BCrypt.hashpw(
      user.password, 
      BCrypt.gensalt()
    );

    await database.connection.query(
      'INSER INTO users (UserName, Email(Login), HashingPassword) VALUES(@username, @email, @password)',
      substitutionValues:{
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

Future<Response> loginHandler(Request request, Database, database) async{
  try{
    final payload = await request.readAsString();
    final data = jsonDecode(payload);

    final email = data['email'];
    final password = data['password'];

    final result = await database.connection.query(
      'SELECT password FROM users WHERE Email(Login) = @email',
      substitutionValues : {'email': email},
    );

    if (result.isEmpty){
      return Response.forbidden('Invalid username or password');
    }

    final storedPassword = result.first[0] as String;

    if (!BCrypt.checkpw(password, storedPassword)){
      return Response.forbidden('Invalid username or password');
    }
    return Response.ok(jsonEncode({'message': 'Login successful'}),
    headers: {'Content-Type': 'application/json'});
  } catch (e){
    return Response.internalServerError(body: 'Error logging in: $e');
  } 
}