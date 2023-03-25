import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/models/app_field/text_field.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class IOOGTextFieldWidget extends StatefulWidget {

  final IOOGTextField ioogTextField;
  
  const IOOGTextFieldWidget ({ Key? key, required this.ioogTextField }): super(key: key);

  @override
  State<IOOGTextFieldWidget> createState() => _IOOGTextFieldWidget();

  IOOGTextField getCustomField() {
    return ioogTextField;
  }
  
  Field getField() {
    return ioogTextField.field;
  }

  void setText(String text) {
    ioogTextField.enteredText = text;
  }

  String labelText() {
    if (getField().required_field == 'y') {
      return '${getField().field_label}*:';
    } else {
      return '${getField().field_label}:';
    }
  }
}

class _IOOGTextFieldWidget extends State<IOOGTextFieldWidget> {

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
                    labelText: widget.labelText(),
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