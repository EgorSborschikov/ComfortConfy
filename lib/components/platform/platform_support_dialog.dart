import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlatformSupportDialog extends StatelessWidget {
  const PlatformSupportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial) {
      // Show Android-style dialog
      return _buildAndroidDialog(context);
    } else {
      // Show iOS-style dialog
      return _buildIosDialog(context);
    }
  }

  Widget _buildAndroidDialog(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.technicalSupport),
      content: const Text('Choose where to write for support:'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Handle Telegram support
            Navigator.of(context).pop();
            _openTelegramSupport();
          },
          child: Text(
            'Telegram',
            style: TextStyle(
              color: theme.cupertinoActionColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle Email support
            Navigator.of(context).pop();
            _openEmailSupport();
          },
          child: Text(
            'Email',
            style: TextStyle(
              color: theme.cupertinoActionColor
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIosDialog(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoAlertDialog(
      title: Text(AppLocalizations.of(context)!.technicalSupport),
      content: const Text('Choose where to write for support:'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            // Handle Telegram support
            Navigator.of(context).pop();
            _openTelegramSupport();
          },
          child: Text(
            'Telegram',
            style: TextStyle(
              color: theme.cupertinoActionColor
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            // Handle Email support
            Navigator.of(context).pop();
            _openEmailSupport();
          },
          child: Text(
            'Email',
            style: TextStyle(
              color: theme.cupertinoActionColor
            ),
          ),
        ),
      ],
    );
  }

  void _openTelegramSupport() {
    // Implement Telegram support logic
  }

  void _openEmailSupport() {
    // Implement Email support logic
  }
}
