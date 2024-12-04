import 'package:comfort_confy/server/services/delete_account_service/delete_account_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Импортируйте ваш файл локализации

class DeleteConfirm extends StatefulWidget {
  final String currentUserEmail;

  const DeleteConfirm({
    super.key,
    required this.currentUserEmail,
  });

  @override
  State<DeleteConfirm> createState() => _DeleteConfirmState();
}

class _DeleteConfirmState extends State<DeleteConfirm> {
  final TextEditingController _emailController = TextEditingController();
  final DeleteAccountService _deleteAccountService = DeleteAccountService();

  void _showConfirmationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.confirmDeleteAccount),
          content: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: AppLocalizations.of(context)!.email),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                if (_emailController.text == widget.currentUserEmail) {
                  _deleteAccountService.deleteUser(_emailController.text).then((_) {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/register'); // Переместите пользователя на экран регистрации
                  }).catchError((error) {
                    print('Error: $error');
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.invalidEmail)),
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.yes),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () => _showConfirmationDialog(context),
      child: Text(AppLocalizations.of(context)!.deleteAccount),
    );
  }
}
