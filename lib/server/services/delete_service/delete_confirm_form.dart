//Доработать сервисы связи с backend, чтобы удаление аккаунта осуществлялось по JWT токену, который будет
//возвращаться на почту, указанную пользователем при регистрации (и в БД присвоен только ему???)
import 'package:comfort_confy/mobile/components/buttons/general_button.dart';
import 'package:comfort_confy/mobile/pages/registration_page.dart';
import 'package:comfort_confy/server/services/delete_service/delete_account_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'user_delete_model.dart';

class DeleteConfirmForm extends StatefulWidget{

  const DeleteConfirmForm({super.key});

  @override
  State<DeleteConfirmForm> createState() => _DeleteConfirmFormState();
}

class _DeleteConfirmFormState extends State<DeleteConfirmForm> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();

  void _delete() async {
    final user = UserDeleteModel(
      email: _email_controller.text, 
      password: _password_controller.text,
    );

    try{
      await deleteAccount(user.email, user.password);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const RegistrationPage()),
      );
    } catch (e) {
      print(e); // Обработка ошибок
      //deleteAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        AppLocalizations.of(context)!.deleteAccountMessage
      ),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          CupertinoTextField(
            controller: _email_controller,
            placeholder: AppLocalizations.of(context)!.required,
            prefix: Text(
              AppLocalizations.of(context)!.email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(),
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
          const SizedBox(height: 15),
          CupertinoTextField(
            controller: _password_controller,
            placeholder: AppLocalizations.of(context)!.required,
            prefix: Text(
              AppLocalizations.of(context)!.password,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: const BoxDecoration(),
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
          ),
          const SizedBox(height: 15),
        ],
      ),
      actions: [
        GeneralButton(
          text: AppLocalizations.of(context)!.deleteYes,
          onTap: _delete,
        ),
        const SizedBox(height: 15),
        GeneralButton(
          text: AppLocalizations.of(context)!.cancel,
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}