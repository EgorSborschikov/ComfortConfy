import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../services/analytics_service/analytics_service.dart';
import '../../../widgets/bars/app_bars/general/view_general_app_bar.dart';
import '../../../widgets/bars/bottom_navigation_bars/view_bottom_navigation_bar.dart';
import '../../../widgets/options/settings/view_settings_options.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final int _selectedIndex = 2;
  final AnalyticsService _analyticsService = AnalyticsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: AppLocalizations.of(context)!.settings,
      ),
      bottomNavigationBar:
          GeneralBottomNavigationBar(initialIndex: _selectedIndex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: SettingsOptions(
              context: context, 
              onAnalyticsSwitchChanged: (bool value) {
                _analyticsService.logSwitchEvent('analytics_toggled', {'is_enabled': value});
              },
            ), // Use the new widget here
          ),
        ),
      ),
    );
  }
}
