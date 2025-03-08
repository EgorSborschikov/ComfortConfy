import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBottomNavigationBar extends StatelessWidget {
  final Function(int index) onSelect;
  final List<BottomNavigationBarItem> items;
  final int currentIndex; // Добавляем переменную currentIndex

  const PlatformBottomNavigationBar({
    super.key,
    required this.onSelect,
    required this.items,
    required this.currentIndex, // Добавляем в конструктор
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (theme.isMaterial) {
      return BottomNavigationBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: items,
        currentIndex: currentIndex, // Устанавливаем currentIndex
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.colorScheme.secondary,
        onTap: onSelect,
      );
    } else {
      return CupertinoTabBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        items: items,
        currentIndex: currentIndex, // Устанавливаем currentIndex
        activeColor: theme.primaryColor,
        inactiveColor: theme.colorScheme.secondary,
        onTap: onSelect,
      );
    }
  }
}
