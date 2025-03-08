import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlatformBottomNavigationBar extends StatelessWidget {
  final Function(int index) onSelect;
  final List<BottomNavigationBarItem> items;
  
  const PlatformBottomNavigationBar({
    super.key,
    required this.onSelect,
    required this.items,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedIndex = 0;
    if (theme.isMaterial) {
      return BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: items,
        currentIndex: selectedIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.colorScheme.secondary,
        onTap: onSelect,
      );
    } else {
      return CupertinoTabBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: items,
        currentIndex: selectedIndex,
        activeColor: theme.primaryColor,
        inactiveColor: theme.colorScheme.secondary,
        onTap: onSelect,
      );
    }
  }
}
