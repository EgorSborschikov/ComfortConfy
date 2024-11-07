import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comfort_confy/themes/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                      AppLocalizations.of(context)!.choiceLanguage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const LanguageDropDown(),
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

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropDown> {
  String _selectedLanguage = 'English'; // Начальный выбранный язык

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    // Обновляем начальный выбранный язык в зависимости от текущей локали
    _selectedLanguage = localeProvider.locale.languageCode == 'en' ? 'English' : 'Русский';

    return GestureDetector(
      onTap: () {
        _showCupertinoDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          _selectedLanguage,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  void _showCupertinoDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 250.0,
          child: CupertinoPicker(
            itemExtent: 32.0,
            onSelectedItemChanged: (int index) {
              String selectedLanguage = index == 0 ? 'English' : 'Русский';
              setState(() {
                _selectedLanguage = selectedLanguage;
              });

              // Измените локаль в LocaleProvider и сохраняем выбор
              if (selectedLanguage == 'English') {
                Provider.of<LocaleProvider>(context, listen: false).switchToEnglish();
                Provider.of<LocaleProvider>(context, listen: false).saveLanguagePreference('en'); // Сохраняем выбор
              } else {
                Provider.of<LocaleProvider>(context, listen: false).switchToRussian();
                Provider.of<LocaleProvider>(context, listen: false).saveLanguagePreference('ru'); // Сохраняем выбор
              }
            },
            children: const [
              Text('English'),
              Text('Русский'),
            ],
          ),
        );
      },
    );
  }
}