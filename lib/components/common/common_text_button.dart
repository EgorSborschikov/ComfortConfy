import 'package:flutter/material.dart';

class CommonTextButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;
  final TextStyle? textStyle;

  const CommonTextButton
  (
    {
      super.key,
      required this.text, this.onTap, this.textStyle,
    }
  );

  @override
  // ignore: library_private_types_in_public_api
  _CommonTextButtonState createState() => _CommonTextButtonState();
}

class _CommonTextButtonState extends State<CommonTextButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Center(
        child: Text(
          widget.text,
          style: widget.textStyle
        ),
      ),
    );
  }
}