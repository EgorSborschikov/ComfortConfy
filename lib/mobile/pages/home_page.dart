import 'package:comfort_confy/mobile/components/create_conferention_bottom_sheet.dart';
import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralBottomNavigationBar(),
      floatingActionButton: SizedBox(
        width: 50.0, // Custom width
        height: 50.0, // Custom height
        child: FloatingActionButton(
          onPressed: () {
            createConferencion(context);
          },
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFF5727EC),
          child: const Icon(
            CupertinoIcons.add_circled,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [   
                const SizedBox(height: 30),
                Text(
                  AppLocalizations.of(context)!.callHistory,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}