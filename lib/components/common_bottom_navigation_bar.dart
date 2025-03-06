import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonBottomNavigationBar extends StatefulWidget implements PreferredSizeWidget{
  final int initialIndex;

  const CommonBottomNavigationBar({super.key, required this.initialIndex});

  @override
  _CommonBottomNavigationBarState createState() => _CommonBottomNavigationBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  late int _selectedIndex;

  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.phone,
          ),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.search,
          ),
          label: AppLocalizations.of(context)!.search,
        ),
        BottomNavigationBarItem(
          icon: const Icon(
            CupertinoIcons.settings_solid,
          ),
          label: AppLocalizations.of(context)!.settings,
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedItemColor: const Color(0xFF5727EC),
      unselectedItemColor: Colors.grey,
    );
  }
}