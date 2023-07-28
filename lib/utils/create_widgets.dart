import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/text_widgets/comments_field.dart';
import 'package:namer_app/components/field_widgets/text_widgets/date_field.dart';
import 'package:namer_app/components/image_fields/cholesteatoma.dart';
import 'package:namer_app/components/image_fields/diagram.dart';
import 'package:namer_app/components/image_fields/mastoidectomy.dart';
import 'package:namer_app/components/image_fields/ossicularchain.dart';
import 'package:namer_app/components/image_fields/reasons.dart';
import 'package:namer_app/components/image_fields/stages/stages.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../components/field_widgets/multiple_choice/check_button.dart';
import '../../components/field_widgets/multiple_choice/radio_button.dart';
import '../../components/field_widgets/text_widgets/text_field.dart';
import '../../components/image_fields/audiograms/enter_audiogram.dart';
import '../../models/field/field.dart';
import '../../models/project.dart';
import '../components/image_fields/stages/stage.dart';
import 'logging.dart';

IOOGFieldWidget? fieldWidget(
    IOOGProject project, Field field, FormManager formManager) {
  switch (field.getFieldName()) {
    case 'stage3':
      return Stage(
          field: field,
          formManager: formManager,
          choices: field.createChoices(),
          isSelected: () =>
              formManager
                  .getFormStateNotifier()
                  .value['stage_of_cholesteatoma'] ==
              "3");
    case 'stage4':
      return Stage(
          field: field,
          formManager: formManager,
          choices: field.createChoices(),
          isSelected: () =>
              formManager
                  .getFormStateNotifier()
                  .value['stage_of_cholesteatoma'] ==
              "4");
    case 'stage_of_cholesteatoma':
      return Stages(
          field: field,
          formManager: formManager,
          choices: field.createChoices());
    case 'diagnosis':
      return Reasons(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    case 'last_preop':
      return EnterAudiogram(
        project: project,
        field: field,
        formManager: formManager,
        type: 'PREOP',
      );
    case 'postop_audiogram':
      return EnterAudiogram(
        project: project,
        field: field,
        formManager: formManager,
        type: 'POSTOP',
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
      if (field.getFieldName().contains('date')) {
        return IOOGDateField(
          field: field,
          formManager: formManager,
        );
      }
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
    case 'yesno':
      return IOOGRadioGroup(
        field: field,
        formManager: formManager,
        choices: field.createYesNoChoices(),
      );
    case 'dropdown':
      printLog(field.toJson().toString());
      return IOOGCheckGroup(
        field: field,
        formManager: formManager,
        choices: field.createChoices(),
      );
    default:
      printLog("${field.toJson()}");
      printLog("Field type ${field.getFieldType()} not supported");
      printLog("Field name ${field.getFieldName()}");
      return null;
  }
}
