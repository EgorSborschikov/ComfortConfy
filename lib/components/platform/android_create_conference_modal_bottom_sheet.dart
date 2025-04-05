import 'package:comfort_confy/components/common/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comfort_confy/services/api/create_conference.dart';
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

          return DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Заголовок с иконкой для сворачивания
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.createANewConference,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: theme.primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CommonTextField(
                      controller: _conferenceNameController,
                      prefix: AppLocalizations.of(context)!.conferenceName,
                      isObscure: false,
                    ),
                    const SizedBox(height: 16),
                    if (conferenceLink.isNotEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!.copyLink,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
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
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
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
                      onPressed: () async {
                        if (_conferenceNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Conference name cannot be empty')),
                          );
                          return;
                        }

                        final conferenceData = {
                          'name': _conferenceNameController.text,
                          'created_by': user.id,
                        };

                        try {
                          final response = await createConference(conferenceData);

                          setState(() {
                            conferenceLink = response['link'];
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Conference created successfully!')),
                          );
                          Navigator.of(context).pop(); // Navigate to conference page
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to create conference: $e')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
