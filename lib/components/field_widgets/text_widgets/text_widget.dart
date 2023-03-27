import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/models/field/field.dart';

import '../field_widget.dart';

abstract class IOOGTextWidget extends IOOGFieldWidget {

  final textController = TextEditingController();

  IOOGTextWidget ({ Key? key, required Field field }): super(key: key, field: field);

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
    formKey.currentState!.fields[getFieldName()]?.didChange(getEnteredText());
    formKey.currentState!.save();
  }
}