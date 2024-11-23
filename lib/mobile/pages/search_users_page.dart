import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:comfort_confy/mobile/components/search_users_text_filed.dart';
import 'package:flutter/material.dart';

class SearchUsersPage extends StatelessWidget{
  const SearchUsersPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GeneralAppBar(),
      bottomNavigationBar: GeneralBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                SearchUsersTextFiled(nickname: ' ')
              ],
            ),
          ),
        )
      ),
    );
  }
}