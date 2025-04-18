import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBottomNavigationBar extends StatelessWidget {
  final Function(int index) onSelect;
  final List<BottomNavigationBarItem> items;
  final int currentIndex; 

  const PlatformBottomNavigationBar({
    super.key,
    required this.onSelect,
    required this.items,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (theme.isMaterial) {
      return BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: items,
        currentIndex: currentIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: onSelect,
      );
    } else {
      return CupertinoTabBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: items,
        currentIndex: currentIndex, 
        activeColor: theme.primaryColor,
        inactiveColor: CupertinoColors.inactiveGray,
        onTap: onSelect,
      );
    }
  }
}
