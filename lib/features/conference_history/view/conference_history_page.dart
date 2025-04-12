import 'package:comfort_confy/components/platform/platform.dart';
import 'package:comfort_confy/config.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConferenceHistoryPage extends StatefulWidget {
  const ConferenceHistoryPage({super.key});

  @override
  State<ConferenceHistoryPage> createState() => _ConferenceHistoryPageState();
}

class _ConferenceHistoryPageState extends State<ConferenceHistoryPage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<dynamic> _conferences = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConferences();
  }

  Future<void> _loadConferences() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('http://$baseUrl:8000/list_conferences?created_by=${user.id}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _conferences = data;
          _isLoading = false;
        });
      } else {
        print('Error loading conferences: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Exception occurred: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.callHistory,
        trailing: <Widget>[
          IconButton(
            onPressed: () {
              _loadConferences();
            },
            icon: Icon(
              CupertinoIcons.restart,
              color: theme.cupertinoActionColor,
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: () {
              iosCreateConference(context);
            },
            icon: Icon(
              CupertinoIcons.add,
              color: theme.cupertinoActionColor,
            ),
          ),
        ]
      ),
      floatingActionButton: theme.isMaterial
          ? AndroidFloatActionButton(
              onPressed: () {
                androidCreateConference(context);
              },
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: RefreshIndicator( // Добавлено здесь
            onRefresh: _loadConferences,
            child: _isLoading
                ? Center(child: PlatformProgressIndicator())
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(), // Важно!
                    itemCount: _conferences.length,
                    itemBuilder: (context, index) {
                      final conference = _conferences[index];
                      return Card(
                        color: theme.colorScheme.secondary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(
                            conference['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Created at: ${conference['created_at']}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showConferenceOptions(conference, context);
                            }, 
                            icon: Icon(
                              theme.isMaterial ? Icons.edit : CupertinoIcons.pen
                            )
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
