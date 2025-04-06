import 'package:comfort_confy/services/api/rest/create_conference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> iosCreateConference(BuildContext context) async {
  final TextEditingController _conference_name_controller = TextEditingController();
  final theme = Theme.of(context);

  final user = Supabase.instance.client.auth.currentUser;

  if (user == null){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User not authenticated')),
    );
    return;
  }

  String conferenceLink = '';

  showCupertinoDialog(
    context: context, 
    builder: (BuildContext context){
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          return CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.createANewConference),
            content: Column(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: CupertinoTextField(
                    controller: _conference_name_controller, 
                    placeholder: AppLocalizations.of(context)!.conferenceName, 
                  ),
                ),
                const SizedBox(height: 20),
                if(conferenceLink.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.copyLink)
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: conferenceLink));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Link copied to clipboard')),
                          );
                        }, 
                        icon: Icon(
                          CupertinoIcons.doc_on_clipboard,
                          color: theme.primaryColor)
                      ),
                    ],
                  )
              ],
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  AppLocalizations.of(context)!.cancel
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  AppLocalizations.of(context)!.create
                ),
                onPressed: () async{
                  // Проверка, что название конференции не пустое
                  if (_conference_name_controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Conference name cannot be empty')),
                    );
                    return;
                  }

                  final conferenceData = {
                    'name' : _conference_name_controller.text,
                    'created_by' : user.id
                  };

                  try {
                    final response = await createConference(conferenceData);

                    setState(() {
                      conferenceLink = response['link'];
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Conference created successfully!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create conference: $e')),
                    );
                  }
                },
              ),
            ],
          );
        }
      );
    }
  );
}