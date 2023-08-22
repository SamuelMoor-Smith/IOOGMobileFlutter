import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/services.dart';

import '../field_widget.dart';

class IOOGTextField extends IOOGTextWidget {
  final bool isInteger; // Add the isInteger field here

  IOOGTextField({
    Key? key,
    required Field field,
    required FormManager formManager,
    this.isInteger = false, // Default value if not provided
  }) : super(key: key, field: field, formManager: formManager);

  @override
  IOOGTextWidgetState<IOOGTextField> createState() => _IOOGTextFieldState();
}

class _IOOGTextFieldState extends IOOGTextWidgetState<IOOGTextField> {
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
            labelStyle: TextStyle(color: textSecondaryColor),
            alignLabelWithHint: false,
            filled: true,
          ),
          cursorColor: blackColor,
          keyboardType: (widget as IOOGTextField)
                  .isInteger // Conditionally set the keyboardType
              ? TextInputType.numberWithOptions(signed: true)
              : TextInputType.text,
          textInputAction: TextInputAction.done,
          inputFormatters: (widget as IOOGTextField).isInteger
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly // This ensures only digits can be entered
                ]
              : [], // No formatter for normal text
          onFieldSubmitted: (value) {
            // Handle submission if needed, otherwise this just triggers the 'Done' action
            FocusScope.of(context)
                .requestFocus(FocusNode()); // This line hides the keyboard
          },
        ),
      ),
    );
  }

  @override
  List<Widget> buildFieldWidgets() {
    return [];
  }
}
