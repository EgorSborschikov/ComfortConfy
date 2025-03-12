import 'package:comfort_confy/components/platform/platform.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/home/view/home_page.dart';
import '../../features/login/view/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(

        //Listen to auth state changes
        stream: Supabase.instance.client.auth.onAuthStateChange, 

        //Build appropriate page bases on auth state
        builder: (context, snapshot){

          //loading ...
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: const Center(
                child: PlatformProgressIndicator(),
              ),
            );
          }

          final session = snapshot.hasData ? snapshot.data!.session : null;

          if(session != null) {
            return HomePage();
          } else {
            return LoginPage();
          }
        }
      ),
    );
  }
}