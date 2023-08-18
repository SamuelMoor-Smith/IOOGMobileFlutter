import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/AppColors.dart';
import 'package:namer_app/utils/logging.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../import_toast.dart';
import '../field_widget.dart';

class IOOGDateField extends IOOGTextWidget {
  final DateTime? defaultDate;
  final IOOGProject project;

  IOOGDateField(
      {Key? key,
      required this.project,
      required Field field,
      required FormManager formManager,
      this.defaultDate})
      : super(key: key, field: field, formManager: formManager);

  @override
  IOOGTextWidgetState<IOOGDateField> createState() => _IOOGDateFieldState();

  @override
  fillField(dynamic rawRecord) {
    var fieldName = getFieldName();
    if (rawRecord.containsKey(fieldName)) {
      setEnteredText(rawRecord[fieldName]!);
    }
    if (field.field_name == "date_preop") {
      formManager.updateForm('last_preop',
          getLastPreop(project.getAudiogramInstrument(), textController.text));
      createLastPreopDateToast();
    }
  }
}

class _IOOGDateFieldState extends IOOGTextWidgetState<IOOGDateField> {
  final dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    if ((widget as IOOGDateField).defaultDate != null) {
      widget.textController.text =
          dateFormat.format((widget as IOOGDateField).defaultDate!);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    // Use the date in the text field if it is not empty, otherwise use DateTime.now()
    DateTime initialDate = widget.textController.text.isNotEmpty
        ? dateFormat.parse(widget.textController.text)
        : DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));
    if (picked != null) setDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Offstage(
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
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
      ),
    );
  }

  @override
  List<Widget> buildFieldWidgets() {
    return [];
  }

  void setDate(DateTime date) {
    setState(() {
      widget.textController.text = dateFormat.format(date);
    });
    if (widget.field.field_name == "date_preop") {
      widget.formManager.updateForm(
          'last_preop',
          getLastPreop(
              (widget as IOOGDateField).project.getAudiogramInstrument(),
              widget.textController.text));
      createLastPreopDateToast();
    }
  }
}

String? getLastPreop(IOOGInstrument audiogramInstrument, String preopDate) {
  return audiogramInstrument.getLastPreopAudiogram(preopDate);
}
