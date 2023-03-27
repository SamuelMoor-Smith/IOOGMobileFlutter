import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  void initState() {
    super.initState();
    widget.textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.updateForm();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.getFieldName(),
      validator: widget.validator(),
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
        labelText: widget.getLabelText(),
        labelStyle: TextStyle(color: textSecondaryColor),
        alignLabelWithHint: false,
        filled: true,
      ),
      cursorColor: blackColor,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}