import 'package:comfort_confy/components/common/common_button.dart';
import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/services/api/create_conference.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> androidCreateConferencion(BuildContext context) async {
  final TextEditingController _conference_name_controller = TextEditingController();

  final user = Supabase.instance.client.auth.currentUser;

  if (user == null){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User not authentificated'))
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextField(
                  controller: _conference_name_controller, 
                  prefix: AppLocalizations.of(context)!.conferenceName, 
                  isObscure: false
                ),
                const SizedBox(height: 16),
                CommonButton(
                  text: AppLocalizations.of(context)!.create,
                  onTap: () async {
                    if (_conference_name_controller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Conference name cannot be empty')),
                      );
                      return;
                    }

                    final conferenceData = {
                      'name' : _conference_name_controller,
                      'created_by' : user.id,
                    };

                    try{
                      final response = await createConference(conferenceData);

                      setState(() {
                        conferenceLink = response['link'];
                      });


                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Conference created successfulle!'))
                      );
                      Navigator.of(context).pop(); // Navigate to conference page
                    } catch(e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to create conference: $e')),
                      );
                    }
                  },
                ),

                if(conferenceLink.isNotEmpty) ... [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.copyLink)
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: conferenceLink));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Link copied to clipboard')),
                          );
                        },
                      ),
                    ],
                  )
                ]
              ],
            ),
          );
        }
      );   
    },
  );
}