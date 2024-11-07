import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Начальная локаль

  Locale get locale => _locale;

  void switchToEnglish() {
    _locale = const Locale('en');
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void switchToRussian() {
    _locale = const Locale('ru');
    notifyListeners(); // Уведомляем слушателей об изменении
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners(); // Уведомляем слушателей об изменении
  }
}