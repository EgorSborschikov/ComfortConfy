import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:comfort_confy/mobile/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/contacts_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralBottomNavigationBar extends StatefulWidget {
  const GeneralBottomNavigationBar({super.key});

  @override
  _GeneralBottomNavigationBarState createState() => _GeneralBottomNavigationBarState();
}

class _GeneralBottomNavigationBarState extends State<GeneralBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ContactsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => _pages[index]),
    );
  }

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
            CupertinoIcons.profile_circled,
          ),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Size get preferredSize => const Size.fromHeight(60);
}
