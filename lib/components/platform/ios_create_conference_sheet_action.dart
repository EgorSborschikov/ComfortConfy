import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/features/conference_history/widgets/conference_route.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> iosCreateConference(BuildContext context) async {
  final TextEditingController controller = TextEditingController();
  final theme = Theme.of(context);

  showCupertinoDialog(
    context: context, 
    builder: (BuildContext context){
      return CupertinoAlertDialog(
          title: Text(
            AppLocalizations.of(context)!.createANewConference
          ),
          content: Column(
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CupertinoTextField(
                  controller: controller,
                  placeholder: AppLocalizations.of(context)!.conferenceName,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.copyLink,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.copyLink,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  PlatformSwitch(
                    value: true, 
                    onChanged: (bool value) {

                    }
                  ),
                ],
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: theme.cupertinoAlertColor
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                AppLocalizations.of(context)!.create,
                style: TextStyle(
                  color: theme.cupertinoActionColor
                ),
              ),
              onPressed: () async {
                //Navigator.of(context).pop();
                conferenceRoute(context);
              },
            ),
          ],
        );
      },
    );
}