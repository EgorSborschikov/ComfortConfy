import 'package:comfort_confy/components/common/common_text_button.dart';
import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:comfort_confy/services/rest_api/update_conference_name.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/rest_api/delete_conference.dart';

void showConferenceOptions(Map<String, dynamic> conference, BuildContext context) {
  final theme = Theme.of(context);

  if(theme.isMaterial) {
    showModalBottomSheet(
      context: context, 
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text(AppLocalizations.of(context)!.conferenceNameEdit),
                onTap: () { 
                  Navigator.pop(context);
                  _showEditConferenceNameDialog(context, conference);
                }
              ),
              ListTile(
              leading: Icon(Icons.delete),
              title: Text(AppLocalizations.of(context)!.deleteConference),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConferenceDialog(context, conference);
              },
            ),
            ],
          )
        );
      }
    );
  } else {
    showCupertinoModalPopup(
      context: context, 
      builder: (BuildContext context){
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              CupertinoListTile(
                leading: Icon(CupertinoIcons.pen),
                title: Text(
                  AppLocalizations.of(context)!.conferenceNameEdit,
                  style: const TextStyle(
                    color: CupertinoColors.inactiveGray
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showEditConferenceNameDialog(context, conference);
                }
              ),
              CupertinoListTile(
                leading: Icon(CupertinoIcons.delete),
                title: Text(
                  AppLocalizations.of(context)!.deleteConference,
                  style: const TextStyle(
                    color: CupertinoColors.inactiveGray
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConferenceDialog(context, conference);
                }
              )
            ],
          )
        );
      }
    );
  }
}

Future<void> _showEditConferenceNameDialog(BuildContext context, Map<String, dynamic> conference) async {
  final theme = Theme.of(context);
  final TextEditingController _controller = TextEditingController(text: conference['name']);

  if(theme.isMaterial) {
    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.conferenceNameEdit),
          content: CommonTextField(
            controller: _controller, 
            prefix: AppLocalizations.of(context)!.conferenceName, 
            isObscure: false
          ),
          actions: <Widget>[
            CommonTextButton(
              text: AppLocalizations.of(context)!.cancel,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 10),
            CommonTextButton(
              text: AppLocalizations.of(context)!.accept,
              onTap: () async {
                Navigator.of(context).pop();
                await updateConferenceName(conference['room_id'], _controller.text);
              },
            )
          ],
        );
      }
    );
  } else {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.inputConferenceName),
          content: CupertinoTextField(
            controller: _controller,
            placeholder: AppLocalizations.of(context)!.conferenceName,
          ),
          actions: <Widget>[
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
                AppLocalizations.of(context)!.accept,
                style: TextStyle(
                  color: theme.cupertinoActionColor
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await updateConferenceName(conference['room_id'], _controller.text);
              },
            ),
          ],
        );
      },
    );
  }
}

Future<void> _showDeleteConferenceDialog(BuildContext context, Map<String, dynamic> conference) async {
  final theme = Theme.of(context);

  if (theme.isMaterial) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.deleteConference),
          content: Text(AppLocalizations.of(context)!.deleteConferenceMessage),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.accept),
              onPressed: () async {
                Navigator.of(context).pop();
                await deleteConference(conference['room_id']);
              },
            ),
          ],
        );
      },
    );
  } else {
    await _showCupertinoActionSheetDelete(context, conference);
  }
}

Future<void> _showCupertinoActionSheetDelete(BuildContext context, Map<String, dynamic> conference) async {
  final theme = Theme.of(context);

  await showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: Text(
          AppLocalizations.of(context)!.deleteConference,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        message: Text(AppLocalizations.of(context)!.deleteConferenceMessage),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: TextStyle(
                color: theme.cupertinoActionColor,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.of(context).pop();
              await deleteConference(conference['room_id']);
            },
            child: Text(
              AppLocalizations.of(context)!.deleteConference,
              style: TextStyle(
                color: theme.cupertinoAlertColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}