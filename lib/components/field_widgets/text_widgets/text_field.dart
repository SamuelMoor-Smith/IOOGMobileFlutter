import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class IOOGTextField extends IOOGTextWidget {


  IOOGTextField ({ Key? key, required Field field }): super(key: key, field: field);

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
                    labelText: widget.getLabelText(),
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