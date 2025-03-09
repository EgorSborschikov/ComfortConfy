import 'package:clipboard/clipboard.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:comfort_confy/themes/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'language_drop.dart';

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

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkTheme, 
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                  .ToggleTheme(bool, value);
              }, 
              activeColor: theme.isCupertino ? theme.primaryColor : CupertinoColors.activeGreen,
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
            const LanguageDropDown(),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          AppLocalizations.of(context)!.confidentiality,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: const Color(0xFF5727EC),
              ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.allowAnalytics,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isAnalyticsEnabled,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false).ToggleAnalytics(value);
                widget.onAnalyticsSwitchChanged(value); // Call the callback
              },
              activeColor: theme.isCupertino ? theme.primaryColor : CupertinoColors.activeGreen,
            ),
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
            Spacer(),
            IconButton(
              onPressed: () {
                _copyToClipboard('https://github.com/EgorSborschikov/comfort_confy');
              },
              icon: const Icon(CupertinoIcons.person_add)
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
              icon: const Icon(CupertinoIcons.chat_bubble)
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
                _launchURL('https://github.com/EgorSborschikov/comfort_confy');
              },
              icon: const Icon(CupertinoIcons.chevron_left_slash_chevron_right)
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
            Spacer(),
            IconButton(
              onPressed: () {
                
              },
              icon: const Icon(CupertinoIcons.delete)
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}