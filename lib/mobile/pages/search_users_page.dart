import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_button.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
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
                CupertinoTextField.borderless(
                  placeholder: AppLocalizations.of(context)!.inputNicknameUser,
                  prefix: const Icon(CupertinoIcons.search),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                  style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                ),
                const Divider(),
                CupertinoButton(
                  child: Text(
                    AppLocalizations.of(context)!.search,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color(0xFF5727EC),
                    ),
                  ), 
                  onPressed: () {},
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}