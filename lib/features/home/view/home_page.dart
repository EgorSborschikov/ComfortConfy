import 'package:comfort_confy/components/platform/platform_bottom_navigation_bar.dart';
import 'package:comfort_confy/features/conference_history/conference_history.dart';
import 'package:comfort_confy/features/conference_search/conference_search.dart';
import 'package:comfort_confy/features/settings/settings.dart';
import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController; // Объявляем контроллер

  final List<Widget> _pages = [
    ConferenceHistoryPage(),
    ConferenceSearchPage(),
    SettingsPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex); // Инициализируем контроллер
  }

  void _onSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index); // Переходим к выбранной странице
  }

  @override
  void dispose() {
    _pageController.dispose(); // Очистка контроллера при уничтожении виджета
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: PageView(
        controller: _pageController, 
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: PlatformBottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: theme.isMaterial ? const Icon(Icons.menu_rounded) : const Icon(CupertinoIcons.videocam_circle_fill),
            label: AppLocalizations.of(context)!.callHistory,
          ),
          BottomNavigationBarItem(
            icon: theme.isMaterial ? const Icon(Icons.search) : const Icon(CupertinoIcons.search),
            label: AppLocalizations.of(context)!.search,
          ),
          BottomNavigationBarItem(
            icon: theme.isMaterial ? const Icon(CupertinoIcons.gear_alt) : const Icon(CupertinoIcons.settings_solid),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
        onSelect: _onSelect,
        currentIndex: _currentIndex,
      ),
    );
  }
}