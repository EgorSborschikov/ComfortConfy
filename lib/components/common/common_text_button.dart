import 'package:flutter/material.dart';

class CommonTextButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const CommonTextButton
  (
    {
      super.key,
      required this.text, this.onTap,
    }
  );

  @override
  // ignore: library_private_types_in_public_api
  _CommonTextButtonState createState() => _CommonTextButtonState();
}

class _CommonTextButtonState extends State<CommonTextButton> {
  final Color _textColor = const Color(0xFF007CF7);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            fontFamily: 'Kokoro',
            fontWeight: FontWeight.normal,
            fontSize: 14,
            color: _textColor,
          ),
        ),
      ),
    );
  }
}