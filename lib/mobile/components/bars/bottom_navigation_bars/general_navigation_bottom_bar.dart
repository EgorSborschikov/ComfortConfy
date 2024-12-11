import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:comfort_confy/mobile/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../pages/contacts_page.dart';
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

    if (index == 2) {
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
    const ContactsPage(),
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
            CupertinoIcons.person_2,
          ),
          label: AppLocalizations.of(context)!.contacts,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.person_alt_circle,
          ),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: const Color(0xFF5727EC),
      unselectedItemColor: Colors.grey,
    );
  }

  Size get preferredSize => const Size.fromHeight(60);
}
