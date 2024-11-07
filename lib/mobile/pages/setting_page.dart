import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comfort_confy/themes/theme_provider.dart';

class SettingPage extends StatelessWidget{
  const SettingPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralNavigationBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Text(
                  'Personalization',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark theme on',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    CupertinoSwitch(
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
                      'Choice language',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    LanguageDropDown(),
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

class LanguageDropDown extends StatefulWidget{
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropDown> {
  String _selectedLanguage = 'English'; // Начальный выбранный язык

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedLanguage,
      items: const [
        DropdownMenuItem(
          value: 'English',
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: 'Русский',
          child: Text('Русский'),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedLanguage = newValue!;
          // Измените локаль в LocaleProvider
          if (_selectedLanguage == 'English') {
            Provider.of<LocaleProvider>(context, listen: false).switchToEnglish();
          } else {
            Provider.of<LocaleProvider>(context, listen: false).switchToRussian();
          }
        });
      },
    );
  }
}