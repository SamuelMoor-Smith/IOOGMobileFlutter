import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final VoidCallback? onBackButtonPressed;

  CustomAppBar({
    this.title = "",
    this.backgroundColor,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor; // Get primary color from the theme

    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor ?? primaryColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () async {
          await Future.delayed(Duration(milliseconds: 300));
          if (onBackButtonPressed != null) {
            onBackButtonPressed!();
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
