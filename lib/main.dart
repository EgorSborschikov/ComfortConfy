//import 'package:comfort_confy/firebase_options.dart';
import 'package:comfort_confy/features/settings/view/settings_page.dart';
import 'package:comfort_confy/l10n/locale_provider.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'themes/theme_provider.dart';
import 'themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider localeProvider = LocaleProvider();

  /*final appfb = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  //log(appfb.options.projectId);

  await localeProvider.loadLanguagePreference();

  /*bool isRegistered = await isUserRegistered();
  bool isLogined = await isUserLogined();*/

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: ComfortConfyApp(
        isRegistered: true,
        isLogined: true, /*isRegistered: isRegistered, isLogined: isLogined,*/
      ),
    ),
  );
}

class ComfortConfyApp extends StatelessWidget {
  final bool isRegistered;
  final bool isLogined;

  const ComfortConfyApp(
      {super.key, required this.isRegistered, required this.isLogined});

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
        /*home: isRegistered 
          ? (isLogined 
              ? const HomePage() 
              : const LoginPage()) 
          : const SignUpPage(),*/
        home: const SettingsPage());
  }
}
