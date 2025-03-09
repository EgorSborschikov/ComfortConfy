import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AndroidFloatActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AndroidFloatActionButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0, // Custom width
      height: 50.0, // Custom height
      child: FloatingActionButton(
        onPressed: onPressed,
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF5727EC),
        child: const Icon(
          CupertinoIcons.add_circled,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 35,
        ),
      ),
    );
  }
}
