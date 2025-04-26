import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _primary_color = Color(0xFF5727EC);

TextTheme _buildTextTheme(BuildContext context) {
  return ThemeData(
    fontFamily: defaultTargetPlatform == TargetPlatform.iOS
        ? 'SF Pro Display' // Нативный шрифт для iOS
        : 'Roboto',        // Нативный шрифт для Android
    fontFamilyFallback: defaultTargetPlatform == TargetPlatform.iOS
        ? ['SF Pro Text', 'SF Pro Icons']
        : ['Noto Serif'],
  ).textTheme.apply(
    bodyColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
    displayColor: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,
  );
}

ThemeData buildDarkTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    primaryColor: _primary_color,
    textTheme: _buildTextTheme(context).copyWith(
      titleMedium: const TextStyle(
        fontFamily: 'Kokoro',
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      headlineLarge: const TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _primary_color,
      secondary: const Color.fromARGB(156, 94, 94, 94),
      tertiary: const Color.fromARGB(255, 255, 255, 255),
      onSurface: Colors.white,
    ),
  );
}

ThemeData buildLightTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    primaryColor: _primary_color,
    textTheme: _buildTextTheme(context).copyWith(
      titleMedium: const TextStyle(
        fontFamily: 'Kokoro',
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      headlineLarge: const TextStyle(
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
    ).copyWith(
      color: Colors.grey.withOpacity(0.1),
    ),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      surface: Colors.white,
      seedColor: _primary_color,
      secondary: const Color.fromARGB(156, 209, 209, 209),
      tertiary: const Color.fromARGB(255, 255, 255, 255),
      onSurface: Colors.black,
    ),
  );
}

extension ThemePlatformExtensions on ThemeData {
  bool get isMaterial => defaultTargetPlatform == TargetPlatform.android;
  bool get isCupertino => defaultTargetPlatform == TargetPlatform.iOS;

  Color get cupertinoActionColor => const Color(0xFF3478F7);
  Color get cupertinoAlertColor => const Color(0xFFF82B10);
}
