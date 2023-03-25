import 'package:flutter/material.dart';

import '../../models/app_field/multiple_choice/check_group.dart';
import '../../models/app_field/multiple_choice/radio_button.dart';
import '../../models/app_field/text_field.dart';

Widget _fillTextWidget(fieldWidget, rawRecord) {
  var field_name = fieldWidget.getField().field_name;
  if (rawRecord.containsKey(field_name)) {
    fieldWidget.setText(rawRecord[field_name]);
  }
  return fieldWidget;
}

Widget _fillRadioWidget(fieldWidget, rawRecord) {
  var field_name = fieldWidget.getField().field_name;
  if (rawRecord.containsKey(field_name)) {
    fieldWidget.setChoice(rawRecord[field_name]);
  }
  return fieldWidget;
}

Widget _fillCheckWidget(fieldWidget, rawRecord) {
  var field_name = fieldWidget.getField().field_name;
  for (String name in rawRecord.keys) {
    if (name.startsWith(field_name) && rawRecord[name] == "1") {
      fieldWidget.setChoice(name.split("___")[1]);
    }
  }
  return fieldWidget;
}

Widget? fillField(fieldWidget, rawRecord) {
  var customField = fieldWidget.getCustomField();
  switch (customField.runtimeType) {
    case IOOGTextField:
      return _fillTextWidget(fieldWidget, rawRecord);
    case IOOGMultipleChoiceRadioButton:
      return _fillRadioWidget(fieldWidget, rawRecord); 
    case IOOGMultipleChoiceCheckButton:
      return _fillCheckWidget(fieldWidget, rawRecord);
    default:
      return null;
  }
}