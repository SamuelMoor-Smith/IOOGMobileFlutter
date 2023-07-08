import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/models/section.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../models/instrument.dart';
import '../../../../models/field/field.dart';
import '../../../utils/create_widgets.dart';
import '../../utils/logging.dart';
import '../old/services/fields_service.dart';
import '../common.dart';

Object fieldsBody(IOOGProject project, IOOGInstrument instrument) {
  return Map.of({
    "token": project.token,
    "content": "metadata",
    "format": "json",
    "forms[0]": instrument.getName()
  });
}

Future<List<IOOGSection>?> getFieldsForInstrumentFromREDCAP(
    IOOGProject project, IOOGInstrument instrument) async {
  try {
    var url = Uri.parse(project.apiUrl);
    var response = await http.post(
      url,
      body: fieldsBody(project, instrument),
      headers: headers(),
    );

    if (response.statusCode == 200) {
      List<dynamic> rawFields = json.decode(response.body);
      List<Field> fields = rawFields.map((raw) => Field.fromJson(raw)).toList();

      List<IOOGSection> sections = [];
      // Create new section that is simply the instrument label
      IOOGSection section = IOOGSection(instrument.getLabel());

      for (Field field in fields) {
        // Create a field widget for the field
        IOOGFieldWidget? fieldWidgetInstance = fieldWidget(
            instrument.getProject(), field, instrument.getFormKeyManager());
        if (fieldWidgetInstance != null) {
          if (!fieldWidgetInstance.getSectionHeader().isEmptyOrNull) {
            // If the field widget has a section header, create a new section
            // Add the old section to the instrument
            sections.add(section); // instrument.addSection(section);

            // Create a new section with the section header
            section = IOOGSection(fieldWidgetInstance.getSectionHeader());
          }
          // Add the field widget to the appropriate section
          section.addFieldWidget(fieldWidgetInstance);
        }
      }
      // Add the last section to the instrument
      sections.add(section); // instrument.addSection(section);

      printLog(sections.toString());
      return sections;
    }
  } catch (e) {
    printError(e.toString());
  }

  return null;
}
