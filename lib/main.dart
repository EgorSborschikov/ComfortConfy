import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:comfort_confy/mobile/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'themes/theme_provider.dart';
import 'themes/themes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const ComfortConfyApp(),
    ),
  );
}

class ComfortConfyApp extends StatelessWidget {
  const ComfortConfyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      locale: localeProvider.locale, // Устанавливаем локаль
      supportedLocales: const [
        Locale('en'), // Английский
        Locale('ru'), // Русский
      ],
      localizationsDelegates: const [
        // Добавьте ваши делегаты локализации
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
      home: const SettingPage(),
    );
  }
}