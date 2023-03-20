import 'package:flutter/material.dart';
import 'package:namer_app/models/text_field.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class IOOGTextField extends StatefulWidget {

  final REDCapTextField redCapTextField;

  const IOOGTextField ({ Key? key, required this.redCapTextField }): super(key: key);

  @override
  State<IOOGTextField> createState() => _IOOGTextField();
}

class _IOOGTextField extends State<IOOGTextField> {

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
                    labelStyle: TextStyle(color: textSecondaryColor),
                    alignLabelWithHint: false,
                    filled: true),
                cursorColor: blackColor,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              )
            );
  }
}