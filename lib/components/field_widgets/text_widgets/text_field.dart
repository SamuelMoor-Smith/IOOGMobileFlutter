import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/services/form_key_manager.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class IOOGTextField extends IOOGTextWidget {
  IOOGTextField(
      {Key? key, required Field field, required FormKeyManager formKeyManager})
      : super(key: key, field: field, formKeyManager: formKeyManager);

  @override
  State<IOOGTextField> createState() => _IOOGTextField();
}

class _IOOGTextField extends State<IOOGTextField> {
  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkBranchingLogic(setState, mounted);
    });
    widget.formKeyManager
        .getFormStateNotifier()
        .addListener(() => widget.checkBranchingLogic(setState, mounted));
  }

  @override
  void dispose() {
    widget.formKeyManager
        .getFormStateNotifier()
        .removeListener(() => widget.checkBranchingLogic(setState, mounted));
    super.dispose();
  }

  void _onTextChanged() {
    widget.updateForm();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.shouldShow,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
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
      ),
    );
  }
}
