import 'package:flutter/material.dart';

import '../../models/app_field/multiple_choice/check_group.dart';
import '../../models/app_field/multiple_choice/radio_button.dart';
import '../../models/app_field/text_field.dart';

import '../../components/check_button.dart';
import '../../components/comments_field.dart';
import '../../components/radio_button.dart';
import '../../components/text_field.dart';

Widget? fieldWidget(field) {
  switch (field.field_type) {
    case 'text':
      return IOOGTextFieldWidget(ioogTextField: IOOGTextField(field));
    case 'notes':
      return IOOGCommentsFieldWidget(ioogTextField: IOOGTextField(field));
    case 'radio':
      return IOOGRadioGroup(ioogMultipleChoiceRadioButton: IOOGMultipleChoiceRadioButton(field, field.createChoices(), null));
    case 'checkbox':
      return IOOGCheckGroup(ioogMultipleChoiceCheckButton: IOOGMultipleChoiceCheckButton(field, field.createChoices(), {}));
    default:
      return null;
  }
}