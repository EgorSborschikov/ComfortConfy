import 'package:comfort_confy/components/common/common_button.dart';
import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/features/register/register.dart';
import 'package:comfort_confy/services/supabase_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../components/common/common_text_button.dart';
import '../../../components/common/common_text_field.dart';
import '../../home/home.dart';

class LoginPage extends StatefulWidget {
  
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  
  final authService = AuthServices();

  // ignore: non_constant_identifier_names
  final TextEditingController _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _password_controller = TextEditingController();

  void _login() async {
    final email = _email_controller.text.trim();
    final password = _password_controller.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await authService.signInWithEmailPassword(email, password);
        if (response.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          // Обработка случая, когда ответ не содержит пользователя
          showDialog(
            context: context,
            builder: (context) => PlatformWarningElements(
              title: "Error!",
              content: 'Login failed. Please check your credentials.',
            ),
          );
        }
      } catch (e) {
        // Логирование ошибки
        print('Login error: $e');
        if (e is AuthException) {
          print('Auth error code: ${e.statusCode}');
          print('Auth error message: ${e.message}');
        }
        showDialog(
          context: context,
          builder: (context) => PlatformWarningElements(
            title: "Error!",
            content: 'Login process failed. Please check the logs for more details.',
          ),
        );
      }
    } else {
      // Обработка случая, когда поля пустые
      showDialog(
        context: context,
        builder: (context) => PlatformWarningElements(
          title: "Error!",
          content: 'Email and password cannot be empty.',
        ),
      );
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
                  AppLocalizations.of(context)!.logInComfortConfy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                const SizedBox(height: 32),
                CommonTextField(
                  controller: _email_controller, 
                  prefix: AppLocalizations.of(context)!.email, 
                  isObscure: false,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                CommonTextField(
                  controller: _password_controller, 
                  prefix: AppLocalizations.of(context)!.password, 
                  isObscure: _isObscure,
                  suffix: IconButton(
                    icon: Icon(
                      _isObscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 80),
                CommonTextButton(
                  text: AppLocalizations.of(context)!.dontHaveAnAccountRegister,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const RegisterPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin =
                              Offset(1.0, 0.0); // Начальная позиция (справа)
                          const end = Offset.zero; // Конечная позиция (центр)
                          const curve =
                              Curves.linearToEaseOut; // Кривая анимации

                          // Анимация перемещения
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(
                            milliseconds: 600), // Длительность анимации
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100),
                CommonButton(
                  text: AppLocalizations.of(context)!.login,
                  onTap: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}