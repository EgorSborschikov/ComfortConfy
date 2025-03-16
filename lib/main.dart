import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/services/supabase_services/auth_gate.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as Supabase; // Use 'as' to avoid conflict
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'l10n/locale_provider.dart';
import 'themes/theme_provider.dart';
import 'themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider localeProvider = LocaleProvider();

  await localeProvider.loadLanguagePreference();

  // Инициализация Supabase
  await Supabase.Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: // const ComfortConfyApp(),
      DevicePreview(
        enabled: true,
        builder: (context) => const ComfortConfyApp(),
      ),
    ),
  );
}

class ComfortConfyApp extends StatefulWidget {
  const ComfortConfyApp({super.key});

  @override
  State<ComfortConfyApp> createState() => _ComfortConfyAppState();
}

class _ComfortConfyAppState extends State<ComfortConfyApp> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'ComfortConfy',
      theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
      home: const AuthGate(),
    );
  }
}
