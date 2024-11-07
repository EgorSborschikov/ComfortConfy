import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GeneralAppBar(),
      bottomNavigationBar: GeneralNavigationBottomBar(),
    );
  }

}