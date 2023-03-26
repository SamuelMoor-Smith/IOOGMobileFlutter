import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';

Widget? fieldWidget(field) {
  addToForm(field)
  switch (field.field_type) {
    case 'text':
      return IOOGTextField(field: field);
    case 'notes':
      return IOOGCommentsField(field: field);
    case 'radio':
      return IOOGRadioGroup(field: field, choices: field.createChoices());
    case 'checkbox':
      return IOOGCheckGroup(field: field, choices: field.createChoices());
    default:
      return null;
  }
}

void addToForm(field, fieldValues) {
  final fieldKey = field.field_name as GlobalKey<FormFieldState>;
  fieldValues[fieldKey] = "";
}

Map<String, String> getFieldValuesFromWidgets() {
  final fieldValues = <String, String>{};

  formKey.currentState!.save();

  

  for (final fieldWidget in fieldWidgets) {
    final fieldKey = fieldWidget.key as GlobalKey<FormFieldState>;
    fieldValues[fieldKey.currentState!.widget.fieldName] = fieldKey.currentState!.value;
  }

  return fieldValues;
}