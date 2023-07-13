import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/field/field.dart';
import '../../../utils/form_manager.dart';

class IOOGCommentsField extends IOOGTextWidget {
  IOOGCommentsField(
      {Key? key, required Field field, required FormManager formManager})
      : super(key: key, field: field, formManager: formManager);

  @override
  State<IOOGCommentsField> createState() => _IOOGCommentsField();
}

class _IOOGCommentsField extends State<IOOGCommentsField> {
  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkBranchingLogic(setState, mounted);
    });
    widget.formManager
        .getFormStateNotifier()
        .addListener(() => widget.checkBranchingLogic(setState, mounted));
  }

  @override
  void dispose() {
    widget.formManager
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
}
