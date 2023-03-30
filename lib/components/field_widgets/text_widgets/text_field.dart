import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/instrument.dart';

class IOOGTextField extends IOOGTextWidget {

  IOOGTextField ({ Key? key, required Field field, required Instrument instrument })
  : super(key: key, field: field, instrument: instrument);

  @override
  State<IOOGTextField> createState() => _IOOGTextField();
}

class _IOOGTextField extends State<IOOGTextField> {

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onTextChanged);
    widget.getFormStateNotifier().addListener(() => widget.checkBranchingLogic(setState));
  }

  void _onTextChanged() {
    widget.updateForm();
    widget.updateFormState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.shouldShow,
      child: FormBuilderTextField(
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
      ),
    );
  }
}