import 'package:comfort_confy/server/services/api_service.dart';
import 'package:flutter/cupertino.dart';

class LoginService{
  final ApiService apiService;

  LoginService(this.apiService);
  // ignore: non_constant_identifier_names
  int id_statuses_activity = 2; // deafult state status activity for don't authentificate user(offline)

  void _showDialogSuccsessfulLogin(BuildContext context) {
    showCupertinoDialog<void>(
      context: context, builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Succsessful',
        ),
        content: const Text('You logged is succsessfully!\n Please tap a Login button'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void _showDialogNonSuccsessfulLogin(BuildContext context) {
    showCupertinoDialog<void>(
      context: context, builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Non Succsessful',
        ),
        content: const Text('Falied to log in ComfortConfy!\n Please a try again'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> login(String email, String password, BuildContext context) async {
    final response = await apiService.loginUser(email, password);
    if (response.statusCode == 200) {
      _showDialogSuccsessfulLogin(context);
      id_statuses_activity = 1; // online
    } else {
      _showDialogNonSuccsessfulLogin(context);
    }
  }
}