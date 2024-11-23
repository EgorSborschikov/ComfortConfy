import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:comfort_confy/themes/themes.dart';

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

    return CupertinoButton(
      onPressed: () {
        _showCupertinoDialog(context);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _selectedLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 8.0),
          Icon(CupertinoIcons.globe, 
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
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