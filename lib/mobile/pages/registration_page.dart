import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/mobile/components/general_button.dart';
import 'package:comfort_confy/mobile/components/general_text_button.dart';
import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:comfort_confy/mobile/pages/login_page.dart';
import 'package:comfort_confy/server/services/registration_service/register_process.dart';
import 'package:comfort_confy/server/services/registration_service/user_create_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // ignore: non_constant_identifier_names
  final TextEditingController _nickname_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _password_controller = TextEditingController();

  void _register() async {
    final user = UserCreateModel(
      nickname: _nickname_controller.text,
      email: _email_controller.text,
      password: _password_controller.text,
    );

    try {
      await registerAndSave(user); // Вызов новой функции

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('nickname', user.nickname);
      print('Saved nickname: ${user.nickname}');
      // Перенаправление на HomePage после успешной регистрации
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      print(e); // Обработка ошибок
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110),
                Center(
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.registrationInComfortConfy,
                  textAlign: TextAlign.center),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _nickname_controller,
                  placeholder: AppLocalizations.of(context)!.required, 
                  prefix: Text(
                    AppLocalizations.of(context)!.nickname,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _email_controller,
                  placeholder: AppLocalizations.of(context)!.required,
                  prefix: Text(
                    AppLocalizations.of(context)!.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _password_controller,
                  placeholder: AppLocalizations.of(context)!.required,
                  prefix: Text(
                    AppLocalizations.of(context)!.password,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const SizedBox(height: 50),
                GeneralTextButton(
                  text: AppLocalizations.of(context)!.alreadyHaveAnAccountLogin,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0); // Начальная позиция (справа)
                          const end = Offset.zero; // Конечная позиция (центр)
                          const curve = Curves.linearToEaseOut; // Кривая анимации

                          // Анимация перемещения
                          var tween = Tween(
                            begin: begin, 
                            end: end
                          ).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 600), // Длительность анимации
                      ),
                    );
                  },
                ),
                const SizedBox(height: 80),
                GeneralButton(
                  text: AppLocalizations.of(context)!.register,
                  onTap: _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}