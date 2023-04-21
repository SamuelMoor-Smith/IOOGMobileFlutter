import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';
import 'package:namer_app/components/image_fields/cholesteatoma.dart';
import 'package:namer_app/components/image_fields/diagram.dart';
import 'package:namer_app/components/image_fields/mastoidectomy.dart';
import 'package:namer_app/components/image_fields/ossicularchain.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';
import '../../models/field/field.dart';
import '../../models/instrument/instrument.dart';

IOOGFieldWidget? fieldWidget(Field field, Instrument instrument) {

  switch (field.getFieldName()) {
    // case 'reac':
    //   return AudiogramGroup(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'classification':
      return Cholesteatoma(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'extent_cholesteatoma':
      return Diagram(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'm_mastoid':
      return Mastoidectomy(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'o_ossiculoplasty':
      return OssicularChain(field: field, instrument: instrument, choices: field.createChoices(),); 
  }

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