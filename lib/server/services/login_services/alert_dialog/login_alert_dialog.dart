import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> loginAlertDialog(BuildContext context) async{
  showCupertinoDialog<void>(
    context: context, 
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        AppLocalizations.of(context)!.alertTitle
      ),
      content: Text(
        AppLocalizations.of(context)!.loginAlertMessage
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            AppLocalizations.of(context)!.yes
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () { 
            SystemNavigator.pop();
          },
          child: Text(
            AppLocalizations.of(context)!.no
          ),
        ),
      ],
    ),
  );
}