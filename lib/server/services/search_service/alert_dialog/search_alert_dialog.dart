import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAlertDialog extends StatelessWidget {
  final String message;

  const SearchAlertDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Loading'),
      content: Column(
        children: [
          Text(message),
          const SizedBox(height: 20),
          const CupertinoActivityIndicator(),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
