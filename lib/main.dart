import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:comfort_confy/mobile/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'themes/theme_provider.dart';
import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider localeProvider = LocaleProvider();

  await localeProvider.loadLanguagePreference();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
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
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
      home: const RegistrationPage(),
    );
  }
}