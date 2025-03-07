import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PlatformWarningElements extends StatelessWidget{
  final String title;
  final String content;

  const PlatformWarningElements({super.key, required this.title, required this.content});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if(theme.isCupertino) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
                /// This parameter indicates this action is the default,
                /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.no,
              style: TextStyle(
                color: theme.cupertinoAlertColor
              ),
            ),
          ),
          CupertinoDialogAction(
                /// This parameter indicates the action would perform
                /// a destructive action such as deletion, and turns
                /// the action's text color to red.
          isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
                },
            child: Text(
              AppLocalizations.of(context)!.yes,
              style: TextStyle(
                color: theme.cupertinoActionColor
              ),
            ),
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              AppLocalizations.of(context)!.no
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              AppLocalizations.of(context)!.yes,
            ),
          ),
        ],
      );
    }
  }
}