import 'package:comfort_confy/mobile/components/bars/app_bars/general/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/chooses/times_choices/opening_hours_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comfort_confy/themes/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/bars/bottom_navigation_bars/general_navigation_bottom_bar.dart';
import '../components/chooses/drops/language_drop_down.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: AppLocalizations.of(context)!.settings,
      ),
      bottomNavigationBar: GeneralBottomNavigationBar(initialIndex: _selectedIndex),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
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
                      activeColor: const Color(0xFF5727EC),
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.workingHours,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const OpeningHoursChoice(),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.showActivityStatus,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context).isDarkTheme,
                      onChanged: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .ToggleTheme(bool, value);
                      },
                      activeColor: const Color(0xFF5727EC),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
