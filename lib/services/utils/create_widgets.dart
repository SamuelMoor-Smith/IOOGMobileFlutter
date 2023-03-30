import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';
import '../../models/field/field.dart';
import '../../models/instrument.dart';

Widget? fieldWidget(Field field, Instrument instrument) {
  switch (field.getFieldType()) {
    case 'text':
      return IOOGTextField(field: field, instrument: instrument,);
    case 'notes':
      return IOOGCommentsField(field: field, instrument: instrument,);
    case 'radio':
      return IOOGRadioGroup(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'checkbox':
      return IOOGCheckGroup(field: field, instrument: instrument, choices: field.createChoices(),);
    default:
      return null;
  }
}