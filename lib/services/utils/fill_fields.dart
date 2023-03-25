import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/check_button.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/radio_button.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';

Widget _fillTextWidget(fieldWidget, rawRecord) {
  var field_name = fieldWidget.getField().field_name;
  if (rawRecord.containsKey(field_name)) {
    fieldWidget.setEnteredText(rawRecord[field_name]);
  }
  return fieldWidget;
}

Widget _fillRadioWidget(fieldWidget, rawRecord) {
  var field_name = fieldWidget.getField().field_name;
  if (rawRecord.containsKey(field_name)) {
    fieldWidget.fillChoiceByNum(rawRecord[field_name]);
  }
  return fieldWidget;
}

Widget _fillCheckWidget(fieldWidget, rawRecord) {
  var field_name = fieldWidget.getField().field_name;
  for (String name in rawRecord.keys) {
    if (name.startsWith(field_name) && rawRecord[name] == "1") {
      fieldWidget.fillChoiceByNum(name.split("___")[1]);
    }
  }
  return fieldWidget;
}

Widget? fillField(fieldWidget, rawRecord) {
  switch (fieldWidget.runtimeType) {
    case IOOGTextWidget:
      return _fillTextWidget(fieldWidget, rawRecord);
    case IOOGRadioGroup:
      return _fillRadioWidget(fieldWidget, rawRecord); 
    case IOOGCheckGroup:
      return _fillCheckWidget(fieldWidget, rawRecord);
    default:
      return null;
  }
}