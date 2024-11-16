import 'package:flutter/cupertino.dart';
import 'api_service.dart';

class RegistrationService{
  final ApiService apiService;

  RegistrationService(this.apiService);

  int id_statuses_activity = 2;

  void _showDialogSuccsessfulRegistration(BuildContext context) {
    showCupertinoDialog<void>(
      context: context, builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Succsessful',
        ),
        content: const Text('You register is succsessfully!\n Please tap a Register button'),
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

  void _showDialogNonSuccsessfulRegistration(BuildContext context) {
    showCupertinoDialog<void>(
      context: context, builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Non Succsessful',
        ),
        content: const Text('Faild to register in ComfortConfy!\n Please a try again'),
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


  Future<void> register(String nickname, String email, String password, BuildContext context) async {
    final response = await apiService.registerUser(nickname, email, password);
    if (response.statusCode == 200) {
      _showDialogSuccsessfulRegistration(context);
      id_statuses_activity = 1; // online
    } else {
      _showDialogNonSuccsessfulRegistration(context);
    }
  }
}