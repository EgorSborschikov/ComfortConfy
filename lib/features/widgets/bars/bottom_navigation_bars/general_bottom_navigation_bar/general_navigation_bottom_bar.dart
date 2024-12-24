import 'package:comfort_confy/features/pages/home/home_page/home_page.dart';
import 'package:comfort_confy/features/pages/profile/profile_page/profile_page.dart';
import 'package:comfort_confy/features/pages/settings/settings_page/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralBottomNavigationBar extends StatefulWidget {
  final int initialIndex;

  const GeneralBottomNavigationBar({super.key, required this.initialIndex});

  @override
  _GeneralBottomNavigationBarState createState() => _GeneralBottomNavigationBarState();
}

class _GeneralBottomNavigationBarState extends State<GeneralBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? nickname = prefs.getString('nickname');

      if (nickname != null) {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ProfilePage(nickname: nickname))
        );
      } else {
        print('Nickname not found');
      }
    } else {
      Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => _pages[index]),
    );
    }
  }

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(nickname: ''),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.home,
          ),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.person_alt_circle,
          ),
          label: AppLocalizations.of(context)!.profile,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.settings_solid,
          ),
          label: AppLocalizations.of(context)!.contacts,
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: const Color(0xFF5727EC),
      unselectedItemColor: Colors.grey,
    );
  }

  Size get preferredSize => const Size.fromHeight(60);
}
