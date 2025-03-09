import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    return AlertDialog(
      title: const Text('Support'),
      content: const Text('Choose where to write for support:'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Handle Telegram support
            Navigator.of(context).pop();
            _openTelegramSupport();
          },
          child: const Text('Telegram'),
        ),
        TextButton(
          onPressed: () {
            // Handle Email support
            Navigator.of(context).pop();
            _openEmailSupport();
          },
          child: const Text('Email'),
        ),
      ],
    );
  }

  Widget _buildIosDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Support'),
      content: const Text('Choose where to write for support:'),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () {
            // Handle Telegram support
            Navigator.of(context).pop();
            _openTelegramSupport();
          },
          child: const Text('Telegram'),
        ),
        CupertinoDialogAction(
          onPressed: () {
            // Handle Email support
            Navigator.of(context).pop();
            _openEmailSupport();
          },
          child: const Text('Email'),
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
