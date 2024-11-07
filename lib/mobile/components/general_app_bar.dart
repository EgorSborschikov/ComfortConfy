import 'package:comfort_confy/mobile/pages/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget{
  const GeneralAppBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text(
        'ComfortConfy',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
       actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SettingPage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0); 
                    const end = Offset.zero; 
                    const curve = Curves.linearToEaseOut; 

                    var tween = Tween(
                      begin: begin, 
                      end: end
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 600), // Длительность анимации
                ),
              );
            }, 
            icon: const Icon(CupertinoIcons.gear_alt_fill),
            color: Colors.white,
          ),
        ),
      ],

      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0), 
        child: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.bell_fill),
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}