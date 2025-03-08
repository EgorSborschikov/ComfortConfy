import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/create_conference_modal_bottom_sheet.dart';

class ConferenceHistoryPage extends StatefulWidget {
  const ConferenceHistoryPage({super.key});

  @override
  State<ConferenceHistoryPage> createState() => _ConferenceHistoryPageState();
}

class _ConferenceHistoryPageState extends State<ConferenceHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.callHistory,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}