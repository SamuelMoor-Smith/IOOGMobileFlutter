import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/field/field.dart';
import '../../../utils/form_manager.dart';
import '../field_widget.dart';

class IOOGCommentsField extends IOOGTextWidget {
  IOOGCommentsField(
      {Key? key, required Field field, required FormManager formManager})
      : super(key: key, field: field, formManager: formManager);

  @override
  IOOGTextWidgetState<IOOGCommentsField> createState() =>
      _IOOGCommentsFieldState();
}

class _IOOGCommentsFieldState extends IOOGTextWidgetState<IOOGCommentsField> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.shouldShow,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextFormField(
          controller: widget.textController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: iconColorPrimary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(width: 1, color: iconColorPrimary),
            ),
            labelText: widget.getFieldLabel(),
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
        ),
      ),
    );
  }

  @override
  List<Widget> buildFieldWidgets() {
    return [];
  }
}
