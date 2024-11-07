import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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