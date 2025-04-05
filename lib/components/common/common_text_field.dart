import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final String prefix;
  final bool isObscure;
  final Widget ? suffix;

  CommonTextField({
    super.key,
    required this.controller,
    required this.prefix,
    required this.isObscure, 
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      placeholder: AppLocalizations.of(context)!.required,
      prefix: Text(
        prefix,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //color: Theme.of(context).scaffoldBackgroundColor
        ),
      ),
      obscureText: isObscure,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      suffix: suffix,
    );
  }
}
