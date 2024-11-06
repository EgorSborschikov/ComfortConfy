import 'package:flutter/material.dart';

class GeneralTextButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const GeneralTextButton
  (
    {
      super.key,
      required this.text,
      this.onTap,
    }
  );

  @override
  // ignore: library_private_types_in_public_api
  _GeneralTextButtonState createState() => _GeneralTextButtonState();
}

class _GeneralTextButtonState extends State<GeneralTextButton> {
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