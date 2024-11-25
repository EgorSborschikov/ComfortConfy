import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:comfort_confy/mobile/components/search_users_text_filed.dart';
import 'package:flutter/material.dart';

class SearchUsersPage extends StatelessWidget{
  const SearchUsersPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                //const SearchUsersTextField(nickname: ''),
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.searchResult,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: 10, // Replace with actual item count
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('User $index'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}