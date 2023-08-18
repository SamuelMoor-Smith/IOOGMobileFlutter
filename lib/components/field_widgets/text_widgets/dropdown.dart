import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/components/import_toast.dart';
import 'package:namer_app/models/form.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/utils/logging.dart';

import '../../../models/field/field.dart';
import '../../../utils/form_manager.dart';

class IOOGDropdown extends IOOGTextWidget {
  final IOOGProject project;

  IOOGDropdown(
      {Key? key,
      required Field field,
      required FormManager formManager,
      required this.project})
      : super(key: key, field: field, formManager: formManager);

  @override
  IOOGTextWidgetState<IOOGDropdown> createState() => _IOOGDropdownState();
}

class _IOOGDropdownState extends IOOGTextWidgetState<IOOGDropdown> {
  @override
  List<Widget> buildFieldWidgets() {
    return [
      DropdownButton<String>(
        value: widget.textController.text,
        hint: Text(widget.field.getFieldLabel()),
        onChanged: (String? newValue) {
          setState(() {
            widget.textController.text = newValue!;
          });
          widget.updateForm();

          // Update audiogram timing
          String? surgeryDate = newValue;
          String? audiogramDate = widget.formManager
              .getFormStateNotifier()
              .value['date_of_audiogram'];
          widget.formManager.updateForm('audiogram_timing',
              getAudiogramTiming(audiogramDate, surgeryDate));
          createAudiogamTimingToast();
        },
        items: (widget as IOOGDropdown)
                .project
                .getSurgeryInstrument()
                .getForms()
                .map<DropdownMenuItem<String>>((IOOGForm value) {
              return DropdownMenuItem<String>(
                value: value.toString().substring(0, 10),
                child: Text(value.toString().substring(0, 10)),
              );
            }).toList() +
            [
              DropdownMenuItem<String>(
                value: "",
                child: Text(""),
              )
            ],
      )
    ];
  }

  String? getAudiogramTiming(String? audiogramDate, String? surgeryDate) {
    if (audiogramDate != null &&
        surgeryDate != null &&
        surgeryDate.isNotEmpty &&
        audiogramDate.isNotEmpty) {
      DateTime audiogram = DateTime.parse(audiogramDate.substring(0, 10));
      DateTime surgery = DateTime.parse(surgeryDate.substring(0, 10));
      Duration difference = audiogram.difference(surgery);

      // Before the surgery
      if (difference.isNegative) {
        return '0';
      }
      // Within 4 months after the surgery -> classify 2-month
      else if (difference.inDays <= 120) {
        return '1';
      }
      // Within 1.25 years after the surgery -> classify 1-year
      else if (difference.inDays <= 365 * 1.25) {
        return '2';
      }
      // After 1 year from the surgery (or latest)
      else {
        return '3';
      }
    } else {
      return null;
    }
  }
}
