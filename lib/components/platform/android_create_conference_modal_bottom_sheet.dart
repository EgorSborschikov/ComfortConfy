import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/services/rest_api/create_conference.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> androidCreateConference(BuildContext context) async {
  final theme = Theme.of(context);
  
  final TextEditingController _conferenceNameController = TextEditingController();

  final user = Supabase.instance.client.auth.currentUser;

  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User not authenticated')),
    );
    return;
  }

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          String conferenceLink = '';

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController){
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.createANewConference,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              }, 
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _conferenceNameController,
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
                            //fillColor: const Color.fromARGB(255, 109, 109, 109)
                          ),
                          style: TextStyle(
                            fontSize: 16.0, 
                            color: theme.colorScheme.onSurface
                          ),
                          obscureText: false,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            if(_conferenceNameController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error name!'))
                              );
                              return;
                            }

                            final conferenceData = {
                              'name' : _conferenceNameController.text,
                              'created_by' : user.id
                            };

                            try{
                              final response = await createConference(conferenceData);

                              setState(() {
                                conferenceLink = response['link'];
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Conference created successfully!')),
                              );

                              Navigator.of(context).pop();

                            } catch (e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to create conference: $e')),
                              );
                            }

                          }, 
                          child: Text(
                            AppLocalizations.of(context)!.create,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            ),
          );
        }
      );
    },
  );
}
