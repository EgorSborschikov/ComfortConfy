import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:comfort_confy/mobile/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/contacts_page.dart';

class GeneralNavigationBottomBar extends StatefulWidget {
  const GeneralNavigationBottomBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GeneralNavigationBottomBarState createState() => _GeneralNavigationBottomBarState();
}

class _GeneralNavigationBottomBarState extends State<GeneralNavigationBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ContactsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      _navigateToPage(index);
    }
  }

  void _navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => _pages[index],
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Начальная позиция для слайда
          const end = Offset.zero; // Конечная позиция
          const curve = Curves.linearToEaseOut; // Кривая анимации

          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 600), // Длительность анимации
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(CupertinoIcons.home, 'Home', 0),
          const SizedBox(width: 20),
          _buildNavItem(CupertinoIcons.person_2, 'Contacts', 1),
          const SizedBox(width: 20),
          _buildNavItem(CupertinoIcons.profile_circled, 'Profile', 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Theme.of(context).primaryColor : const Color(0xFF8A8A8A);

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Kokoro',
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
