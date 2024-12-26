import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../chooses/drops/view_language_drop.dart';
import '../../../chooses/times_choices/working_hours/view_working_hours_choose.dart';
import 'package:comfort_confy/themes/theme_provider.dart';

class SettingsOptions extends StatelessWidget {
  final BuildContext context;
  final ValueChanged<bool> onAnalyticsSwitchChanged;

  const SettingsOptions({super.key, required this.context,required this.onAnalyticsSwitchChanged});

  @override
  Widget build(BuildContext context) {
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
              activeColor: Theme.of(context).primaryColor
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
            const WorkingHoursChoice(),
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
              activeColor: Theme.of(context).primaryColor
            ),
          ],
        ),
        const SizedBox(height: 30),
        /*Row(
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
                onAnalyticsSwitchChanged(value); // Call the callback
              },
              activeColor: Theme.of(context).primaryColor //const Color(0xFF5727EC),
            ),
          ],
        ),*/
      ],
    );
  }
}