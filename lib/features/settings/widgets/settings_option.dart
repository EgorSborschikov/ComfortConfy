import 'package:clipboard/clipboard.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:comfort_confy/themes/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsOptions extends StatefulWidget {
  final BuildContext context;
  final ValueChanged<bool> onAnalyticsSwitchChanged;

  const SettingsOptions({super.key, required this.context,required this.onAnalyticsSwitchChanged});

  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {

  void _copyToClipboard(String text) {
    FlutterClipboard.copy(text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.inviteUsers)),
      );
    });
  }

  Future<void> _openGitHubRepo() async {
    const String url = '$sourceCode';
    print('Пытаемся открыть: $url'); 
    final Uri githubUri = Uri.parse(url);

    try {
      final bool canLaunch = await canLaunchUrl(githubUri);
      print('canLaunchUrl результат: $canLaunch'); 

      if (canLaunch) {
        await launchUrl(
          githubUri,
          mode: LaunchMode.externalApplication
        );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ошибка: URL не поддерживается или браузер не найден'),
            ),
          );
        }
      }
    } catch (e) {
      print('Ошибка при открытии: $e'); // Детальный вывод ошибки
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
      children: [
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.personalization,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: const Color(0xFF5727EC),
              ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.onDarkTheme,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            PlatformSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkTheme,
              onChanged: (value) { 
                Provider.of<ThemeProvider>(context, listen: false)
                  .ToggleTheme(bool, value);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.choiceLanguage,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const PlatformLanguageDrop(),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.other,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: const Color(0xFF5727EC),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.inviteUsers,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                _copyToClipboard('$sourceCode/releases');
              },
              icon: Icon(
                theme.isMaterial ? Icons.person_add_alt_1_rounded : CupertinoIcons.person_add,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.technicalSupport,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PlatformSupportDialog();
                  },
                );
              },
              icon: Icon(
                theme.isMaterial ? Icons.chat_rounded : CupertinoIcons.chat_bubble,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.productSourceCode,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                _openGitHubRepo();
              },
              icon: Icon(
                theme.isMaterial ? Icons.code : CupertinoIcons.chevron_left_slash_chevron_right,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.deleteAccount,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                platformDeleteAccount(context);
              },
              icon: Icon(
                theme.isMaterial ? Icons.delete : CupertinoIcons.delete,
                color: theme.cupertinoAlertColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}