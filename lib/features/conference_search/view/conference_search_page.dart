import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/platform/platform.dart';
import '../../../services/api/rest/join_conference.dart';
import '../../../services/api/rest/list_conference.dart';
import '../../conference/view/conference_page.dart';

class ConferenceSearchPage extends StatefulWidget {
  const ConferenceSearchPage({super.key});

  @override
  State<ConferenceSearchPage> createState() => _ConferenceSearchPageState();
}

class _ConferenceSearchPageState extends State<ConferenceSearchPage> {

  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _conferences = [];

  Future<void> _searchConferences() async{
    setState(() {
      _isLoading = true;
    });

    try{
      final conferences = await searchConferences(_searchController.text);
      setState(() {
        _conferences = conferences;
      });

    } catch(e) {
      print('Error searching conferences: $e');

    } finally{
      setState(() {
        _isLoading = false;
      });
    }
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      placeholder: AppLocalizations.of(context)!.inputConferenceName, 
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(CupertinoIcons.arrow_2_circlepath),
                    onPressed: _searchConferences,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.searchResult,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              const Divider(),
              Expanded(
                child: _isLoading
                  ? Center(child: PlatformProgressIndicator())
                  : ListView.builder(
                      itemCount: _conferences.length,
                      itemBuilder: (context, index) {
                      final theme = Theme.of(context);
                      final conference = _conferences[index];
                        return Card(
                          color: theme.colorScheme.secondary,
                          elevation: 0, // Убираем тень
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Убираем скругленные углы
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
}
