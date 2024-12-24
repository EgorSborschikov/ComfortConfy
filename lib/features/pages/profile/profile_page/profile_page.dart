import 'package:comfort_confy/features/models/users/profile_settings_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/bars/app_bars/general/view_general_app_bar.dart';
import '../../../widgets/bars/bottom_navigation_bars/view_bottom_navigation_bar.dart';
import '../../../widgets/options/profile/view_profile_option.dart';

class ProfilePage extends StatefulWidget {
  final String nickname;

  const ProfilePage({super.key, required this.nickname});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 1;

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
    int? openingHour = prefs.getInt('opening_hour');
    int? openingMinute = prefs.getInt('opening_minute');
    int? closingHour = prefs.getInt('closing_hour');
    int? closingMinute = prefs.getInt('closing_minute');

    setState(() {
      nickname = loadedNickname ?? widget.nickname; // если ника не найден, то используем переданный nickname
      information = ''; // Задайте значение информации, если необходимо
      if (openingHour != null && openingMinute != null && closingHour != null && closingMinute != null) {
        workingHours = '${openingHour.toString().padLeft(2, '0')}:${openingMinute.toString().padLeft(2, '0')} - ${closingHour.toString().padLeft(2, '0')}:${closingMinute.toString().padLeft(2, '0')}';
      }

      if (workingHours.isEmpty) {
        print('Working hours not found');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        title: AppLocalizations.of(context)!.profile,
      ),
      bottomNavigationBar: GeneralBottomNavigationBar(initialIndex: _selectedIndex),
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
                ProfileOptions(context: context), // Use the new widget here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
