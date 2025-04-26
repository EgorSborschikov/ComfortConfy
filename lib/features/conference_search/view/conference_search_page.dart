import 'package:comfort_confy/features/conference/conference.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/platform/platform.dart';
import '../../../services/rest_api/join_conference.dart';
import '../../../services/rest_api/list_conferences.dart';

class ConferenceSearchPage extends StatefulWidget {
  const ConferenceSearchPage({super.key});

  @override
  State<ConferenceSearchPage> createState() => _ConferenceSearchPageState();
}

class _ConferenceSearchPageState extends State<ConferenceSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _conferences = [];
  List<dynamic> _filteredConferences = [];

  @override
  void initState() {
    super.initState();
    _loadConferences();
    _searchController.addListener(_filterConferences);
  }

  Future<void> _loadConferences() async{
    setState(() {
      _isLoading = true;
    });

    try{
      final conferences = await listConferences('');
      setState(() {
        _conferences = conferences;
        _filteredConferences = conferences;
      });

    } catch(e) {
      print('Error searching conferences: $e');

    } finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterConferences() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredConferences = _conferences.where((conference) {
        final name = conference['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  Future<void> _joinConference(String roomId, String conferenceName) async {
    try {
      await joinConference(roomId);
      
      // Переход на экран комнаты конференции
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConferencePage(
            roomId: roomId,
            conferenceName: conferenceName,
            isHost: false, // Пользователь не является создателем
          ),
        ),
      );
    } catch (e) {
      print('Ошибка при присоединении к конференции: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PlatformAppBar(
        title: AppLocalizations.of(context)!.search,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      placeholder: AppLocalizations.of(context)!.inputConferenceName, 
                      style: TextStyle(
                        color: theme.colorScheme.onSurface
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              Expanded(
                child: _isLoading
                  ? Center(child: PlatformProgressIndicator())
                  : ListView.builder(
                      itemCount: _filteredConferences.length,
                      itemBuilder: (context, index) {
                      final theme = Theme.of(context);
                      final conference = _filteredConferences[index];
                        return Card(
                          color: theme.colorScheme.secondary,
                          elevation: 0, // Убираем тень
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), 
                          ),
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                          title: Text(
                            conference['name'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Link: ${conference['link']}'),
                          trailing: IconButton(
                            onPressed: () {
                              // Join conference room
                              _joinConference(conference['room_id'], conference['name']);
                            },
                            icon: theme.isMaterial ? Icon(Icons.arrow_circle_right_outlined) : Icon(CupertinoIcons.arrowtriangle_right_fill)
                          ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
