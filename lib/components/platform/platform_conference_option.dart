import 'package:comfort_confy/components/common/common_text_button.dart';
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
          title: Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.conferenceNameEdit,
            style: TextStyle(
              color: theme.colorScheme.onSurface
            ),
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.conferenceName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: theme.primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: theme.primaryColorDark),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              filled: true,
            ),
            style: TextStyle(
              fontSize: 16.0, 
              color: theme.colorScheme.onSurface
            ),
            obscureText: false,
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: CommonTextButton(
                    text: AppLocalizations.of(context)!.cancel,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(width: 20), // Разделитель между кнопками
                Expanded(
                  child: CommonTextButton(
                    text: AppLocalizations.of(context)!.accept,
                    onTap: () async {
                      Navigator.of(context).pop();
                      await updateConferenceName(conference['room_id'], _controller.text);
                    },
                  ),
                ),
              ],
            ),
          ]
        );
      }
    );
  } else {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            AppLocalizations.of(context)!.inputConferenceName,
            style: TextStyle(
              color: theme.colorScheme.onSurface
            ),
          ),
          content: CupertinoTextField(
            controller: _controller,
            placeholder: AppLocalizations.of(context)!.conferenceName,
            style: TextStyle(
              color: theme.colorScheme.onSurface
            ),
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
          title: Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.deleteConference,
            style: TextStyle(
              color: theme.colorScheme.onSurface
            ),
          ),
          content: Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.deleteConferenceMessage,
            style: TextStyle(
              color: theme.colorScheme.onSurface
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    } ,
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                      style: const TextStyle(
                        color: CupertinoColors.activeBlue
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextButton(
                    child: Text(
                      AppLocalizations.of(context)!.accept,
                      style: const TextStyle(
                        color: CupertinoColors.systemRed
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await deleteConference(conference['room_id']);
                    },
                  ),
                ),
              ],
            )
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface
          ),
        ),
        message: Text(
          AppLocalizations.of(context)!.deleteConferenceMessage,
          style: TextStyle(
            color: theme.colorScheme.onSurface
          ),
        ),
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