import 'package:comfort_confy/l10n/locale_provider.dart';
import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:comfort_confy/mobile/pages/login_page.dart';
import 'package:comfort_confy/mobile/pages/registration_page.dart';
import 'package:comfort_confy/server/services/registration_service/register_process.dart';
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

  bool isRegistered = await isUserRegistered();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: ComfortConfyApp(isRegistered: isRegistered),
    ),
  );
}

class ComfortConfyApp extends StatelessWidget {
  final bool isRegistered;

  const ComfortConfyApp({super.key, required this.isRegistered});

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
      home: isRegistered ? const HomePage() : const RegistrationPage(),
    );
  }
}