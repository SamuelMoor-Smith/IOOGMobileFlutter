import 'package:flutter/material.dart';
import 'package:namer_app/style/text/text_styles.dart';

class TitleListTile extends StatelessWidget {
  final String labelText;
  final String? fieldNote;

  TitleListTile({required this.labelText, this.fieldNote});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        labelText,
        style: primaryTextStyle(),
      ),
      subtitle: fieldNote != null && fieldNote!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                fieldNote!,
                style: secondaryTextStyle(),
              ),
            )
          : null,
      visualDensity: VisualDensity(vertical: -4),
    );
  }
}
