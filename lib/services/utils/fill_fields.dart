import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/check_button.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/radio_button.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_field.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';

Widget _fillTextWidget(IOOGTextWidget fieldWidget, rawRecord) {
  var fieldName = fieldWidget.getFieldName();
  if (rawRecord.containsKey(fieldName)) {
    fieldWidget.setEnteredText(rawRecord[fieldName]);
  }
  return fieldWidget;
}

Widget _fillRadioWidget(IOOGRadioGroup fieldWidget, rawRecord) {
  var fieldName = fieldWidget.getFieldName();
  if (rawRecord.containsKey(fieldName)) {
    fieldWidget.fillChoiceByNum(rawRecord[fieldName]);
  }
  return fieldWidget;
}

Widget _fillCheckWidget(IOOGCheckGroup fieldWidget, rawRecord) {
  var fieldName = fieldWidget.getFieldName();
  for (String name in rawRecord.keys) {
    if (name.startsWith(fieldName) && rawRecord[name] == "1") {
      fieldWidget.fillChoiceByNum(name.split("___")[1]);
    }
  }
  return fieldWidget;
}

Widget? fillField(fieldWidget, rawRecord) {
  switch (fieldWidget.runtimeType) {
    case IOOGTextField:
      return _fillTextWidget(fieldWidget, rawRecord);
    case IOOGCommentsField:
      return _fillTextWidget(fieldWidget, rawRecord);
    case IOOGRadioGroup:
      return _fillRadioWidget(fieldWidget, rawRecord); 
    case IOOGCheckGroup:
      return _fillCheckWidget(fieldWidget, rawRecord);
    default:
      return null;
  }
}