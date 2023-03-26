import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';
import '../../models/field/field.dart';

Widget? fieldWidget(Field field) {
  switch (field.getFieldType()) {
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