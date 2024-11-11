import 'dart:io';
import 'package:shelf/shelf.dart';
//import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:postgres/postgres.dart';
import 'api/api.dart';

Future<void> main() async {
  final connection = PostgreSQLConnection(
    '37.139.41.47',
    5432,
    'comfort_confy_database',
    username: 'igorik',
    password: '5263',
  );
  await connection.open();
  print('Connected to PostgreSQL database');

  final api = Api(connection);
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(api.router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Server listening on port ${server.port}');
}