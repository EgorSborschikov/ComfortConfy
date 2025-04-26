import 'package:comfort_confy/themes/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? trailing;

  const PlatformAppBar({super.key, required this.title, this.trailing});
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if(theme.isMaterial) {
        return AppBar(
            title: Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: theme.scaffoldBackgroundColor,
        );
    } else {
        return CupertinoNavigationBar(
            middle: Text(
              title,
              style: theme.textTheme.headlineLarge,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: theme.scaffoldBackgroundColor,
            trailing: trailing != null && trailing!.isNotEmpty
            ? Row(
              mainAxisSize: MainAxisSize.min,
                children: trailing!,
              )
            : null,
        );
    }
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}