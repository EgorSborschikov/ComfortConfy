import 'package:comfort_confy/mobile/pages/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistrationPage extends StatelessWidget{
  RegistrationPage({super.key});

  final TextEditingController _user_name_constroller = TextEditingController();
  final TextEditingController _email_constroller = TextEditingController();
  final TextEditingController _password_constroller = TextEditingController();

  Future<void> Register() async{
    
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
                const CupertinoTextField(
                  //controller: _nickNameController,
                  placeholder: 'required',
                  prefix: Text(
                    'Nickname',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                const CupertinoTextField(
                  //controller: _emailController,
                  placeholder: 'required',
                  prefix: Text(
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 32),
                const CupertinoTextField(
                  //controller: _passwordController,
                  placeholder: 'required',
                  prefix: Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(),
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: ()  => const LoginPage(), //onTap,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                  ),
                  child: const Text(
                    'Already have an account? Log in',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 124, 247,1),
                      fontFamily: 'kokoro',
                      fontSize: 14
                  ),
                    ),
                ),
                const SizedBox(height: 45),
                CupertinoButton.filled(
                    disabledColor: const Color.fromRGBO(87, 39, 236, 1),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      //selectionColor:  Color.fromRGBO(87, 39, 236, 1),
                    ),
                    onPressed: () {} //()=> Register(context)
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}