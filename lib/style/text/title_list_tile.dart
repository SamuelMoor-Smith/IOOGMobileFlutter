import 'package:flutter/material.dart';
import 'package:namer_app/style/text/text_styles.dart';

class TitleListTile extends StatelessWidget {
  final String labelText;

  TitleListTile({required this.labelText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        labelText,
        style: primaryTextStyle(),
      ),
      visualDensity: VisualDensity(vertical: -4),
    );
  }
}
