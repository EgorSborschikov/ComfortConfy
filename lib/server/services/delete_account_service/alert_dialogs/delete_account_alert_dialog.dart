import 'package:comfort_confy/mobile/pages/register/registration_page.dart';
import 'package:comfort_confy/server/services/delete_account_service/alert_dialogs/delete_confirm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteAccountAlertDialog(BuildContext context) async {
  // Получение сохраненного email из SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? currentUserEmail = prefs.getString('email');

  if (currentUserEmail == null) {
    // Если email не найден, показать сообщение об ошибке
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email not found')),
    );
    return;
  }

  showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        AppLocalizations.of(context)!.confirmDeleteAccount,
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            // Вызов виджета DeleteConfirm как функции
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => DeleteConfirm(currentUserEmail: currentUserEmail),
              ),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.yes,
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!.no,
          ),
        ),
      ],
    ),
  );
}
