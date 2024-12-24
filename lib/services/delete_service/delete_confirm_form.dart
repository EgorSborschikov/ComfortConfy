import 'package:comfort_confy/features/pages/sing_and_log_in/sign_up/sign_up_page/sign_up_page.dart';
import 'package:comfort_confy/features/widgets/buttons/general_button/general_button.dart';
import 'package:comfort_confy/services/delete_service/delete_account_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'user_delete_model.dart';

class DeleteConfirmForm extends StatefulWidget {
  const DeleteConfirmForm({super.key});

  @override
  State<DeleteConfirmForm> createState() => _DeleteConfirmFormState();
}

class _DeleteConfirmFormState extends State<DeleteConfirmForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _delete() async {
    final user = UserDeleteModel(
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      await deleteAccount(user);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const SignUpPage()),
      );
    } catch (e) {
      print(e); // Обработка ошибок
      // deleteAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        AppLocalizations.of(context)!.deleteAccountMessage,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          CupertinoTextField(
            controller: _emailController,
            placeholder: AppLocalizations.of(context)!.required,
            prefix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
          const SizedBox(height: 15),
          CupertinoTextField(
            controller: _passwordController,
            placeholder: AppLocalizations.of(context)!.required,
            prefix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                AppLocalizations.of(context)!.password,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              GeneralButton(
                text: AppLocalizations.of(context)!.cancel,
                onTap: () {
                  Navigator.of(context).pop();
                },
                //textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              GeneralButton(
                text: AppLocalizations.of(context)!.deleteYes,
                onTap: _delete,
                //textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
