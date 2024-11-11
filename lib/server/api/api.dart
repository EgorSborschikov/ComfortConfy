import 'dart:convert';
import 'dart:io';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
//import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  final PostgreSQLConnection connection;
  Api(this.connection);

  Router get router {
    final router = Router();

    router.post('/register', (Request request) async {
      final payload = await request.readAsString();
      final userData = json.decode(payload);

      if (userData['UserName'] == null || userData['Email(Login)'] == null || userData['PasswordHash'] == null) {
        return Response(HttpStatus.badRequest, body: 'Invalid data');
      }
      
      try{
        await connection.query('''
          INSERT INTO public.users ("UserName", "Email(Login)", "PasswordHash", "IDStatusActivity") 
          VALUES (@name, @email, @password, @status)
        ''', substitutionValues: {
          'name': userData['UserName'],
          'email': userData['Email(Login)'],
          'password': userData['PasswordHash'],
          'status': 1, // Пример значения для IDStatusActivity
        });

        return Response(HttpStatus.ok, body: 'User registered successfully');
      } catch (e){
        return Response(HttpStatus.internalServerError, body: 'Error: ${e.toString()}');
      }
    
    });

    router.post('/login', (Request request) async {
      final payload = await request.readAsString();
      final loginData = json.decode(payload);

      // Проверка валидности данных
      if (loginData['Email(Login)'] == null || loginData['PasswordHash'] == null) {
        return Response(HttpStatus.badRequest, body: 'Invalid data');
      }

      // Выполнение запроса на проверку пользователя
      final result = await connection.query('''
        SELECT * FROM public.users 
        WHERE "Email(Login)" = @email AND "PasswordHash" = @password
      ''', substitutionValues: {
        'email': loginData['Email(Login)'],
        'password': loginData['PasswordHash'],
      });

      if (result.isNotEmpty) {
        return Response(HttpStatus.ok, body: 'User logged in successfully');
      } else {
        return Response(HttpStatus.unauthorized, body: 'Invalid email or password');
      }
    });

    return router;
  }
}