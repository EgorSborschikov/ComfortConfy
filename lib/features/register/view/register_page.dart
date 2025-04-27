import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:comfort_confy/features/home/home.dart';
import 'package:comfort_confy/services/supabase_services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import '../../../components/common/common_text_button.dart';
import '../../../components/platform/platform.dart';
import '../../login/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;
  
  final authService = AuthServices();
  
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password_controller = TextEditingController();
  final TextEditingController _password_confirm_controller = TextEditingController();
  
  void _register(BuildContext context) async {
    final email = _email_controller.text;
    final password = _password_controller.text;
    final confirmPassword = _password_confirm_controller.text;

    if (password == confirmPassword && email.isNotEmpty && password.isNotEmpty) {
      try {
        final response = await authService.signUpWithEmailPassword(email, password);
        if (response.user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => PlatformWarningElements(
              title: "Error!",
              content: 'Registration failed. Please try again.',
            ),
          );
        }
      } catch (e) {
        print("Registration error: $e");
        showDialog(
          context: context,
          builder: (context) => PlatformWarningElements(
            title: "Error!",
            content: 'Registration process failed. Try again?',
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => PlatformWarningElements(
          title: "Error!",
          content: 'Please fill in all fields and ensure passwords match.',
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
                    AppLocalizations.of(context)!.registrationInComfortConfy,
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
                  const SizedBox(height: 32),
                  CommonTextField(
                    controller: _password_confirm_controller, 
                    prefix: AppLocalizations.of(context)!.confirm, 
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
                  const SizedBox(height: 30),
                  CommonTextButton(
                  text: AppLocalizations.of(context)!.alreadyHaveAnAccountLogin,
                  textStyle: const TextStyle(
                    color: CupertinoColors.activeBlue
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                          const LoginPage(),
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
                const SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () => _register(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.zero
                    ), 
                    child: Container(
                      width: double.infinity, 
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), 
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.register,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }
}