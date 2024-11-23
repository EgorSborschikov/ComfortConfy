import 'package:comfort_confy/mobile/components/general_app_bar.dart';
import 'package:comfort_confy/mobile/components/general_navigation_bottom_bar.dart';
import 'package:comfort_confy/mobile/models/profile_settings_model.dart';
import 'package:comfort_confy/mobile/pages/search_users_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';

import '../components/blocked_user_list_bottom_sheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nickname = '';
  String information = '';
  String workingHours = '';
  bool isOnline = false;
  String lastSeen = 'Last seen recently';
  bool isSwitchDisabled = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String? loadedNickname = prefs.getString('nickname');
    if (loadedNickname == null) {
      print('No nickname found in SharedPreferences');
    }

    int? openingHour = prefs.getInt('opening_hour');
    int? openingMinute = prefs.getInt('opening_minute');
    int? closingHour = prefs.getInt('closing_hour');
    int? closingMinute = prefs.getInt('closing_minute');

    setState(() {
      nickname = loadedNickname ?? ''; // нет никакого ника - ставим пустую строку
      if (openingHour != null && openingMinute != null && closingHour != null && closingMinute != null) {
        workingHours = '${openingHour.toString().padLeft(2, '0')}:${openingMinute.toString().padLeft(2, '0')} - ${closingHour.toString().padLeft(2, '0')}:${closingMinute.toString().padLeft(2, '0')}';
      }

      if (workingHours.isEmpty) {
        print('Working hours not found');
      }
    });
  }


  void _copyToClipboard(BuildContext context, String text) {
    FlutterClipboard.copy(text).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.inviteUsers)),
      );
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(),
      bottomNavigationBar: const GeneralBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSettingsModel(
                  nickname: nickname, 
                  information: information, 
                  workingHours: workingHours, 
                  isOnline: isOnline, 
                  lastSeen: lastSeen
                ),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.other,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: const Color(0xFF5727EC),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                     Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => const SearchUsersPage()),
                    );
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10), // Отступ между иконкой и текстом
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.search),
                      ),
                      const Icon(CupertinoIcons.search),                      
                    ],
                  ),
                ),
                const Divider(), 
                GestureDetector(
                  onTap: () {
                    _copyToClipboard(context, 'https://example.com/download'); // Замените на реальную ссылку
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10), // Отступ между иконкой и текстом
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.inviteUsers),
                      ),
                      const Icon(CupertinoIcons.person_add),                      
                    ],
                  ),
                ),
                const Divider(), // Разделитель между элементами
                GestureDetector(
                  onTap: () {
                    _launchURL('https://t.me/your_telegram_bot'); // Замените на реальную ссылку
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.technicalSupport),
                      ),
                      const Icon(CupertinoIcons.headphones),
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://github.com/EgorSborschikov/comfort_confy');
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.productSourceCode),
                      ),
                      const Icon(CupertinoIcons.chevron_left_slash_chevron_right),
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    showBlockedUsersList(context);
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.blockedUsersList),
                      ),
                      const Icon(CupertinoIcons.minus_circle),                      
                    ],
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                     // экран в разработке
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 10), // Отступ между иконкой и текстом
                      Expanded(
                        child: Text(AppLocalizations.of(context)!.deleteAccount),
                      ),
                      const Icon(CupertinoIcons.delete),                      
                    ],
                  ),
                ),
                const Divider(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
