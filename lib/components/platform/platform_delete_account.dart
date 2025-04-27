import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:comfort_confy/services/supabase_services/auth_gate.dart';
import 'package:comfort_confy/services/supabase_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../common/common_text_button.dart';
import 'platform_warning_elements.dart';

final TextEditingController _passwordController = TextEditingController();
final TextEditingController _passwordConfirmController = TextEditingController();
final authService = AuthServices();
final user = Supabase.instance.client.auth.currentUser;

Future<void> platformDeleteAccount(BuildContext context) async {
  final theme = Theme.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (theme.platform == TargetPlatform.android) {
        return _buildAndroidDeleteAccountDialog(context);
      } else {
        return _buildIosDeleteAccountDialog(context);
      }
    },
  );
}

Widget _buildAndroidDeleteAccountDialog(BuildContext context) {
  return AlertDialog(
    title: Text(
      AppLocalizations.of(context)!.deleteAccountTitle,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.deleteAccountMessage,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        const SizedBox(height: 10),
        CommonTextField(
          controller: _passwordController,
          prefix: AppLocalizations.of(context)!.password,
          isObscure: false,
        ),
        const SizedBox(height: 10),
        CommonTextField(
          controller: _passwordConfirmController,
          prefix: AppLocalizations.of(context)!.confirm,
          isObscure: true,
        ),
      ],
    ),
    actions: <Widget>[
      CommonTextButton(
        text: AppLocalizations.of(context)!.deleteAccount,
        onTap: () => _delete(context),
      ),
      CommonTextButton(
        text: AppLocalizations.of(context)!.cancel,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}

Widget _buildIosDeleteAccountDialog(BuildContext context) {
  return CupertinoAlertDialog(
    title: Text(
      AppLocalizations.of(context)!.technicalSupport,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonTextField(
          controller: _passwordController,
          prefix: AppLocalizations.of(context)!.password,
          isObscure: false,
        ),
        CommonTextField(
          controller: _passwordConfirmController,
          prefix: AppLocalizations.of(context)!.confirm,
          isObscure: true,
        ),
      ],
    ),
    actions: <Widget>[
      CommonTextButton(
        text: AppLocalizations.of(context)!.deleteAccount,
        onTap: () => _delete(context),
      ),
      CommonTextButton(
        text: AppLocalizations.of(context)!.cancel,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ],
  );
}

Future<void> _delete(BuildContext context) async {
  if (_passwordController.text == _passwordConfirmController.text &&
      _passwordController.text.isNotEmpty &&
      _passwordConfirmController.text.isNotEmpty) {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await authService.deleteAccount(user.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthGate()
          ));
      } else {
        // Обработка случая, когда пользователь не аутентифицирован
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User a not auth')),
        );
      }
    } catch (e) {
      const PlatformWarningElements(
          title: "Error!", content: 'Account delete failed. Try again?');
    }
  }
}