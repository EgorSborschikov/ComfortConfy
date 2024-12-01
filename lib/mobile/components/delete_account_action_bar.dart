import 'package:comfort_confy/server/services/delete_account_service/alert_dialogs/delete_account_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> deleteAccountActionBar(BuildContext context) async{
  showCupertinoModalPopup(
    context: context, 
    builder: (BuildContext context) => CupertinoActionSheet(
      title: Text(
        AppLocalizations.of(context)!.deleteAccount
      ),
      message: Text(
        AppLocalizations.of(context)!.deleteAccountMessage
      ),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            deleteAccountAlertDialog(context);
          }, 
          child: Text(
            AppLocalizations.of(context)!.deleteYes,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: const Color(0xFF5727EC),
            ),
          )
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: Text(
            AppLocalizations.of(context)!.closeDeleteActionSheet
          )
        ),
      ],
    ),
  );
}