import 'package:comfort_confy/components/platform/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/settings_option.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.settings,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SettingsOptions(
              context: context,
              onAnalyticsSwitchChanged: (bool value) {
                //_analyticsService.logSwitchEvent('analytics_toggled', {'is_enabled': value});
              },
            ), // Use the new widget here
          ),
        ),
      ),
    );
  }
}
