import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget{
  const GeneralAppBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF5727EC),
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
            onPressed: () {}, 
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