import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../l10n/locale_provider.dart';

class PlatformLanguageDrop extends StatefulWidget{
  const PlatformLanguageDrop({super.key});

  @override
  State<PlatformLanguageDrop> createState() => _PlatformLanguageDropState();
}

class _PlatformLanguageDropState extends State<PlatformLanguageDrop> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    _selectedLanguage = localeProvider.locale.languageCode == 'en' ? 'English' : 'Русский';

    if(theme.isMaterial) {
      return TextButton(
        onPressed: () { 
          _showAndroidDialog(context);
        }, 
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedLanguage,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.language, 
              color: Colors.grey,
            ),
          ],
        ),
      );
    } else {
      return CupertinoButton(
        onPressed: () {
          _showCupertinoDialog(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedLanguage,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(width: 8.0),
            const Icon(CupertinoIcons.globe, 
              color: CupertinoColors.inactiveGray,
            ),
          ],
        ),
      );
    }
  }

  // Нативные виджеты для выбора языка
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
              _onLanguageSelected(selectedLanguage);
            },
            children: const [
              Text(
                'English',
                style: TextStyle(
                  color: CupertinoColors.inactiveGray
                ),
              ),
              Text(
                'Русский',
                style: TextStyle(
                  color: CupertinoColors.inactiveGray
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAndroidDialog(BuildContext context) {
    String selectedLanguage = _selectedLanguage;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  RadioListTile<String>(
                    title: const Text('English'),
                    value: 'English',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Русский'),
                    value: 'Русский',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      _onLanguageSelected(selectedLanguage);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.zero
                    ), 
                    child: Container(
                      width: double.infinity, 
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.accept,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Метод смены языка 
  void _onLanguageSelected(String selectedLanguage) {
    setState(() {
      _selectedLanguage = selectedLanguage;
    });

    // Update the locale in LocaleProvider and save the preference
    if (selectedLanguage == 'English') {
      Provider.of<LocaleProvider>(context, listen: false).switchToEnglish();
      Provider.of<LocaleProvider>(context, listen: false).saveLanguagePreference('en');
    } else {
      Provider.of<LocaleProvider>(context, listen: false).switchToRussian();
      Provider.of<LocaleProvider>(context, listen: false).saveLanguagePreference('ru');
    }
  }
}