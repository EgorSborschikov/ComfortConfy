import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{
  bool _isDarkTheme = false;
  bool _isAnalyticsEnabled = false;
  
  ThemeProvider(){
    _loadTheme();
  }

  bool get isDarkTheme => _isDarkTheme;
  bool get isAnalyticsEnabled => _isAnalyticsEnabled;

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  Future<void> ToggleTheme(bool, value) async {
    _isDarkTheme = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    notifyListeners();
  } 

  Future<void> ToggleAnalytics(bool value) async {
    _isAnalyticsEnabled = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAnalyticsOn', isAnalyticsEnabled);
    notifyListeners();
  }
}