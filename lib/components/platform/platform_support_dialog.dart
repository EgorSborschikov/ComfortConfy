import 'package:comfort_confy/components/common/common_text_button.dart';
import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class PlatformSupportDialog extends StatelessWidget {
  const PlatformSupportDialog({super.key});
  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (theme.isMaterial) {
      return _buildAndroidDialog(context);
    } else {
      return _buildIosDialog(context);
    }
  }

  Widget _buildAndroidDialog(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.technicalSupport,
        style: TextStyle(
          color: theme.colorScheme.onSurface
        ),
      ),
      content: Text(
        AppLocalizations.of(context)!.chooseSupport,
        style: TextStyle(
          color: theme.colorScheme.onSurface
        ),
      ),
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
        const SizedBox(width: 67),
        TextButton(
          onPressed: () {
            // Handle Email support
            Navigator.of(context).pop();
            _openEmailSupport(context);
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

    return CupertinoActionSheet(
      title: Text(
        AppLocalizations.of(context)!.technicalSupport,
        style: const TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
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
            _openEmailSupport(context);
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

  void _openTelegramSupport() async {
    final Uri tgAppUri = Uri.parse('$botLink');

    try {
      
      if (await canLaunchUrl(tgAppUri)) {
        await launchUrl(tgAppUri);
      } else {
        
        await launchUrl(tgAppUri);
      }
    } catch (e) {
      throw 'Ошибка при открытии Telegram: $e';
    }
  }

  void _openEmailSupport(BuildContext context) async {
    final TextEditingController _bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.sendMessageToSupport,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface
            ),
          ),
          content: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.inputMessageText, 
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              const SizedBox(height: 10),
              CommonTextField(
                controller: _bodyController, 
                prefix: '',
                isObscure: false,
              ),
            ],
          ),
          actions: [
            CommonTextButton(
              onTap: () {
                Navigator.of(context).pop();
              },
              text: AppLocalizations.of(context)!.cancel,
              textStyle: const TextStyle(
                color: CupertinoColors.activeBlue
              ),
            ),
            const SizedBox(height: 10),
            CommonTextButton(
              onTap: () {
                final body = _bodyController.text;
                _sendEmail(techSuppMail, 'Problems with app. Problem lore:', body);
                Navigator.of(context).pop();
              },
              text: AppLocalizations.of(context)!.send,
              textStyle: const TextStyle(
                color: CupertinoColors.activeBlue
              ),
            ),
          ],
        );
      },
    );
  }

  void _sendEmail(String recipient, String subject, String body) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipient],
      isHTML: false,
    );

    final FlutterEmailSender emailSender = FlutterEmailSender();

    try {
      await FlutterEmailSender.send(email);
      print("Письмо успешно отправлено");
    } catch (e) {
      print("Ошибка при отправке письма: $e");
    }
  }
}
