import 'package:flutter/material.dart';

const _primary_color = Color(0xFF5727EC);

const _textTheme = TextTheme(
  titleMedium: TextStyle(
    fontFamily: 'Kokoro',
    fontWeight: FontWeight.normal,
    fontSize: 14,
  ),

  headlineLarge: TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.bold,
    fontSize: 20,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primary_color,
  textTheme: _textTheme,
  scaffoldBackgroundColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark, 
    seedColor: _primary_color,
    secondary: const Color.fromRGBO(138, 138, 138, 44),
    tertiary: const Color.fromARGB(255, 255, 255, 255)
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: _primary_color,
  textTheme: _textTheme,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  dividerTheme: DividerThemeData(
    color: Colors.grey.withOpacity(0.1),
  ),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light, 
    surface: Colors.white, 
    seedColor: _primary_color,
    secondary: const Color.fromRGBO(217, 217, 217, 100),
  ),
);