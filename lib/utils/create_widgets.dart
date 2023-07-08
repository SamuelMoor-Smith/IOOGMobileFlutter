import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';
import 'package:namer_app/components/image_fields/cholesteatoma.dart';
import 'package:namer_app/components/image_fields/diagram.dart';
import 'package:namer_app/components/image_fields/mastoidectomy.dart';
import 'package:namer_app/components/image_fields/ossicularchain.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';
import '../../components/image_fields/audiograms/enter_audiogram.dart';
import '../../models/field/field.dart';
import '../../models/project.dart';

IOOGFieldWidget? fieldWidget(
    IOOGProject project, Field field, FormManager formManager) {
  switch (field.getFieldName()) {
    // case 'reac':
    //   return AudiogramGroup(field: field, instrument: instrument, choices: field.createChoices(),);
    case 'last_preop':
      return EnterAudiogram(
        project: project,
        field: field,
        formManager: formManager,
      );
    case 'classification':
      return Cholesteatoma(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    case 'extent_cholesteatoma':
      return Diagram(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    case 'm_mastoid':
      return Mastoidectomy(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    case 'o_ossiculoplasty':
      return OssicularChain(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
  }

  switch (field.getFieldType()) {
    case 'text':
      return IOOGTextField(
        field: field,
        formManager: formManager,
      );
    case 'notes':
      return IOOGCommentsField(
        field: field,
        formManager: formManager,
      );
    case 'radio':
      return IOOGRadioGroup(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    case 'checkbox':
      return IOOGCheckGroup(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    default:
      return null;
  }
}
