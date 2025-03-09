import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final Widget? trailing;

  const PlatformAppBar({super.key, required this.title, this.trailing});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if(theme.isMaterial) {
        return AppBar(
            title: Text(
                title,
                style:  theme.textTheme.headlineLarge,
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: theme.scaffoldBackgroundColor,
        );
    } else {
        return CupertinoNavigationBar(
            middle: Text(
                title,
                style:  theme.textTheme.headlineLarge,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: theme.scaffoldBackgroundColor,
            trailing: trailing,
        );
    }
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}