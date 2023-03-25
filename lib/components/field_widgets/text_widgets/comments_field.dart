import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/field/field.dart';

class IOOGCommentsField extends IOOGTextWidget {

  IOOGCommentsField ({ Key? key, required Field field }): super(key: key, field: field);

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
                  labelText: widget.getLabelText(),
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