import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class IOOGTextField extends IOOGTextWidget {
  IOOGTextField(
      {Key? key, required Field field, required FormManager formKeyManager})
      : super(key: key, field: field, formKeyManager: formKeyManager);

  @override
  State<IOOGTextField> createState() => _IOOGTextField();
}

class _IOOGTextField extends State<IOOGTextField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // widget.updateForm();
      widget.checkBranchingLogic(setState, mounted);
    });
    widget.textController.addListener(_onTextChanged);
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
    return Offstage(
      offstage: !widget.shouldShow,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextFormField(
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
