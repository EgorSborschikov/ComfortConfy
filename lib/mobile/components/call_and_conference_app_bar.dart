import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CallAndConferenceAppBar extends StatefulWidget{
  //final String name;

  const CallAndConferenceAppBar({super.key, //required this.name
  });

  @override
  State<CallAndConferenceAppBar> createState() => _CallAndConferenceAppBarState();
}

class _CallAndConferenceAppBarState extends State<CallAndConferenceAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      /*title: Text(
        widget.name,
        style: const TextStyle(
          fontFamily: 'kokoro',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),*/
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(CupertinoIcons.speaker_3_fill),
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {}, 
              icon: const Icon(CupertinoIcons.camera),
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {}, 
              icon: const Icon(CupertinoIcons.mic),
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {}, 
              icon: const Icon(CupertinoIcons.desktopcomputer),
              color: Colors.white,
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {}, 
              icon: const Icon(CupertinoIcons.xmark_circle_fill),
              color: const Color.fromARGB(255, 158, 12, 1),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}