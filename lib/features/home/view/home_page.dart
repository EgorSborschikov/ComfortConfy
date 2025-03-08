import 'package:comfort_confy/components/platform/platform_bottom_navigation_bar.dart';
import 'package:comfort_confy/features/conference_history/view/conference_history_page.dart';
import 'package:comfort_confy/features/conference_search/view/conference_search_page.dart';
import 'package:comfort_confy/features/settings/view/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    ConferenceHistoryPage(),
    ConferenceSearchPage(),
    SettingsPage()
  ];

  void _onSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
      return Scaffold(
      body: PageView(
        controller: PageController(initialPage: _currentIndex),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: PlatformBottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.phone,),
            label: AppLocalizations.of(context)!.callHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.search),
            label: AppLocalizations.of(context)!.search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.settings_solid,),
            label: AppLocalizations.of(context)!.settings,
          ),
        ], 
        onSelect: _onSelect
      ),
    );
  }
}