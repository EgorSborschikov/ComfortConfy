import 'package:comfort_confy/mobile/components/general_button.dart';
import 'package:comfort_confy/mobile/components/general_text_button.dart';
import 'package:comfort_confy/mobile/pages/login_page.dart';
import 'package:comfort_confy/server/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationPage extends StatefulWidget{
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // ignore: non_constant_identifier_names
  final ApiService api_service = ApiService();
  // ignore: non_constant_identifier_names
  final TextEditingController _username_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _password_controller = TextEditingController();

  void registerUser() async{
    bool isSuccess = await api_service.registerUser(
      _username_controller.text,
      _email_controller.text,
      _password_controller.text,
    );

    if (isSuccess) {
      // Переход на главный экран или уведомление об успехе
    } else {
      // Ошибка регистрации
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
                const Text('Registration in VideoCalls',
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _username_controller,
                  placeholder: 'required',
                  prefix: const Text(
                    'Nickname',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _email_controller,
                  placeholder: 'required',
                  prefix: const Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _password_controller,
                  placeholder: 'required',
                  prefix: const Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  obscureText: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                ),
                const SizedBox(height: 50),
                GeneralTextButton(
                  text: 'Already have an account? Log in',
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
                  text: 'Register',
                  onTap: registerUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}