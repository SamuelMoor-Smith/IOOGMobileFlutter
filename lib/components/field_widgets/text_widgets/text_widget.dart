import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/models/instrument.dart';

import '../field_widget.dart';

abstract class IOOGTextWidget extends IOOGFieldWidget {

  final textController = TextEditingController();

  IOOGTextWidget ({ Key? key, required Field field, required Instrument instrument })
  : super(key: key, field: field, instrument: instrument);

  @override
  bool isFilled() {
    return textController.text.isNotEmpty;
  }

  setEnteredText(String text) {
    textController.text = text;
  }

  String getEnteredText() {
    return textController.text;
  }

  @override
  updateForm() {
    instrument.getFormKey().currentState!.fields[getFieldName()]?.didChange(getEnteredText());
    instrument.getFormKey().currentState!.save();
  }
}