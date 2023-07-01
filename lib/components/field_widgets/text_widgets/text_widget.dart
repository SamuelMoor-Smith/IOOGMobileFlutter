import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_key_manager.dart';

import '../field_widget.dart';

abstract class IOOGTextWidget extends IOOGFieldWidget {
  final textController = TextEditingController();

  IOOGTextWidget(
      {Key? key, required Field field, required FormKeyManager formKeyManager})
      : super(key: key, field: field, formKeyManager: formKeyManager);

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
    formKeyManager.updateForm(getFieldName(), getEnteredText());
  }
}
