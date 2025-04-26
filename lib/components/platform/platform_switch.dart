import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSwitch extends StatelessWidget{
  final bool value;
  final ValueChanged<bool> onChanged;

  const PlatformSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if(theme.isMaterial) {
      return Switch(
        value: value, 
        onChanged: onChanged,
        activeColor: theme.primaryColor,
      );
    } else {
      return CupertinoSwitch(
        value: value, 
        onChanged: onChanged,
        activeColor: CupertinoColors.activeGreen,
        inactiveTrackColor: CupertinoColors.inactiveGray,
      );
    }
  }
}