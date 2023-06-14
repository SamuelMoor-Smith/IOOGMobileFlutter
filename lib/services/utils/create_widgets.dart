import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';
import 'package:namer_app/components/image_fields/cholesteatoma.dart';
import 'package:namer_app/components/image_fields/diagram.dart';
import 'package:namer_app/components/image_fields/mastoidectomy.dart';
import 'package:namer_app/components/image_fields/ossicularchain.dart';
import 'package:namer_app/services/form_key_manager.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';
import '../../components/image_fields/audiograms/enter_audiogram.dart';
import '../../models/field/field.dart';

IOOGFieldWidget? fieldWidget(Field field, FormKeyManager formKeyManager) {
  switch (field.getFieldName()) {
    // case 'reac':
    //   return AudiogramGroup(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'last_preop':
      return EnterAudiogram(
        field: field,
        formKeyManager: formKeyManager,
      );
    case 'classification':
      return Cholesteatoma(
        field: field,
        formKeyManager: formKeyManager,
        choices: field.createChoices(),
      );
    case 'extent_cholesteatoma':
      return Diagram(
        field: field,
        formKeyManager: formKeyManager,
        choices: field.createChoices(),
      );
    case 'm_mastoid':
      return Mastoidectomy(
        field: field,
        formKeyManager: formKeyManager,
        choices: field.createChoices(),
      );
    case 'o_ossiculoplasty':
      return OssicularChain(
        field: field,
        formKeyManager: formKeyManager,
        choices: field.createChoices(),
      );
  }

  switch (field.getFieldType()) {
    case 'text':
      return IOOGTextField(
        field: field,
        formKeyManager: formKeyManager,
      );
    case 'notes':
      return IOOGCommentsField(
        field: field,
        formKeyManager: formKeyManager,
      );
    case 'radio':
      return IOOGRadioGroup(
        field: field,
        formKeyManager: formKeyManager,
        choices: field.createChoices(),
      );
    case 'checkbox':
      return IOOGCheckGroup(
        field: field,
        formKeyManager: formKeyManager,
        choices: field.createChoices(),
      );
    default:
      return null;
  }
}
