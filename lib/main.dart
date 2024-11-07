import 'package:comfort_confy/mobile/pages/home_page.dart';
//import 'package:comfort_confy/mobile/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/theme_provider.dart';
import 'themes/themes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const ComfortConfyApp(),
    ),
  );
}

class ComfortConfyApp extends StatelessWidget {
  const ComfortConfyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.isDarkTheme ? darkTheme : lightTheme,
          home: const HomePage(),
        );
      },
    );
  }
}