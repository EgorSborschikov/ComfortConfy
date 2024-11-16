import 'package:comfort_confy/mobile/components/general_button.dart';
import 'package:comfort_confy/mobile/components/general_text_button.dart';
import 'package:comfort_confy/mobile/pages/registration_page.dart';
import 'package:comfort_confy/server/services/api_service.dart';
import 'package:comfort_confy/server/services/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: non_constant_identifier_names
  final TextEditingController _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _password_controller = TextEditingController();

  final ApiService apiService = ApiService();
  final LoginService loginService = LoginService(ApiService());
  
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
                const Text('Login in VideoCalls',
                    textAlign: TextAlign.center),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  obscureText: true,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 80),
                GeneralTextButton(
                  text: 'Don`t have an account? Register',
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => RegistrationPage(),
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
                const SizedBox(height: 100),
                GeneralButton(
                  text: 'Login',
                  onTap: () async {
                    String email = _email_controller.text.trim();
                    String password = _password_controller.text.trim();

                    // Проверка на пустые поля
                    if (email.isEmpty || password.isEmpty) {
                      _showErrorDialog(context, 'Please fill in both fields');
                      return;
                    }

                    // Вызов функции логина
                    await loginService.login(email, password, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showErrorDialog(BuildContext context, String message) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}