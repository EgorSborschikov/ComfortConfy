import 'package:comfort_confy/mobile/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralNavigationBottomBar extends StatefulWidget{
  const GeneralNavigationBottomBar({super.key});
  
  @override
  // ignore: library_private_types_in_public_api
  _GeneralNavigationBottomBarState createState() => _GeneralNavigationBottomBarState();
}

class _GeneralNavigationBottomBarState extends State<GeneralNavigationBottomBar>{
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    //ContactsPage(),
    //ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(CupertinoIcons.home, 'Home', 0),
          const SizedBox(width: 48), 
          _buildNavItem(CupertinoIcons.person_2, 'Contacts', 1),
          const SizedBox(width: 48), 
          _buildNavItem(CupertinoIcons.profile_circled, 'Profile', 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFF5727EC) : const Color(0xFF8A8A8A);

    return GestureDetector(
      onTap: () {
        _onItemTapped(index);
//логика для перехода на соответствующий экран

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _pages[index]),
        );
      },
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