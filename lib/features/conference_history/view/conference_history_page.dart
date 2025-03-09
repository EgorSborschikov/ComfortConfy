import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConferenceHistoryPage extends StatefulWidget {
  const ConferenceHistoryPage({super.key});

  @override
  State<ConferenceHistoryPage> createState() => _ConferenceHistoryPageState();
}

class _ConferenceHistoryPageState extends State<ConferenceHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.callHistory,
        trailing: IconButton(
          onPressed: () {
            iosCreateConference(context);
          },
          icon: Icon(
            CupertinoIcons.add,
            color: theme.cupertinoActionColor,
          ),
        ),
      ),
      floatingActionButton: theme.isMaterial
          ? AndroidFloatActionButton(
              onPressed: () {
                androidCreateConferencion(context);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                // Your other content here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
