import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../field_widget.dart';

abstract class IOOGTextWidget extends IOOGFieldWidget {
  final textController = TextEditingController();

  IOOGTextWidget(
      {Key? key, required Field field, required FormManager formManager})
      : super(key: key, field: field, formManager: formManager);

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
  fillField(dynamic rawRecord) {
    var fieldName = getFieldName();
    if (rawRecord.containsKey(fieldName)) {
      setEnteredText(rawRecord[fieldName]!);
    }
  }

  @override
  void clearField() {
    setEnteredText('');
  }

  @override
  updateForm() {
    formManager.updateForm(getFieldName(), getEnteredText());
  }
}
