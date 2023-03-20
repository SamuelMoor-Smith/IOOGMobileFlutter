import 'package:flutter/material.dart';
import 'package:namer_app/models/text_field.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class IOOGCommentsField extends StatefulWidget {

  final REDCapTextField redCapTextField;

  const IOOGCommentsField ({ Key? key, required this.redCapTextField }): super(key: key);

  @override
  State<IOOGCommentsField> createState() => _IOOGCommentsField();
}

class _IOOGCommentsField extends State<IOOGCommentsField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
                style: primaryTextStyle(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: iconColorPrimary),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(width: 1, color: iconColorPrimary),
                  ),
                  labelText: widget.redCapTextField.field.field_label,
                  hintText: "write....",
                  hintStyle: TextStyle(color: textSecondaryColor),
                  labelStyle: TextStyle(color: textSecondaryColor),
                  alignLabelWithHint: true,
                  filled: true,
                ),
                cursorColor: blackColor,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                textInputAction: TextInputAction.done,
              ));
  }
}