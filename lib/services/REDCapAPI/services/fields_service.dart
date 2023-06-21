import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/models/section.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/instrument.dart';
import '../../../models/field/field.dart';
import '../../../utils.dart';
import '../../utils/create_widgets.dart';
import '../api_constants.dart';

Object fieldsBody(IOOGInstrument instrument) {
  return Map.of({
    "token": APIConstants.token!,
    "content": "metadata",
    "format": "json",
    "forms[0]": instrument.getName()
  });
}

Object fieldsFillBody(IOOGInstrument instrument) {
  return Map.of({
    "token": APIConstants.token!,
    "content": "record",
    "format": "json",
    "type": "flat",
    "forms[0]": instrument.getName(),
    "records[0]": APIConstants.studyId!,
  });
}

Future<void> fetchFields(IOOGInstrument instrument) async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);
    var response = await http.post(
      url,
      body: fieldsBody(instrument),
      headers: APIConstants.headers(),
    );

    if (response.statusCode == 200) {
      List<dynamic> rawFields = json.decode(response.body);
      List<Field> fields = rawFields.map((raw) => Field.fromJson(raw)).toList();

      // Create new section that is simply the instrument label
      IOOGSection section = IOOGSection(instrument.getLabel());

      for (Field field in fields) {
        // Create a field widget for the field
        IOOGFieldWidget? fieldWidgetInstance =
            fieldWidget(field, instrument.getFormKeyManager());
        if (fieldWidgetInstance != null) {
          if (!fieldWidgetInstance.getSectionHeader().isEmptyOrNull) {
            // If the field widget has a section header, create a new section
            // Add the old section to the instrument
            instrument.addSection(section);
            // Create a new section with the section header
            section = IOOGSection(fieldWidgetInstance.getSectionHeader());
          }
          // Add the field widget to the appropriate section
          section.addFieldWidget(fieldWidgetInstance);
        }
      }
      // Add the last section to the instrument
      instrument.addSection(section);
    }
  } catch (e) {
    printError(e.toString());
  }
}

Future<void> fillFields(IOOGInstrument instrument) async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);
    var response = await http.post(url,
        body: fieldsFillBody(instrument), headers: APIConstants.headers());

    if (response.statusCode == 200) {
      List<dynamic> rawRecords = json.decode(response.body);
      if (rawRecords.isNotEmpty) {
        instrument
            .getAllFieldWidgets()
            .forEach((fieldWidget) => fieldWidget.fillField(rawRecords[0]));
      }
    }
  } catch (e) {
    printError(e.toString());
  }
}

Future<void> fillFieldsFromRecord(
    IOOGInstrument instrument, dynamic record) async {
  try {
    instrument
        .getAllFieldWidgets()
        .forEach((fieldWidget) => fieldWidget.fillField(record));
  } catch (e) {
    printError(e.toString());
  }
}

Future<void> fillForms(IOOGInstrument instrument) async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);
    var response = await http.post(url,
        body: fieldsFillBody(instrument), headers: APIConstants.headers());

    if (response.statusCode == 200) {
      List<dynamic> rawRecords = json.decode(response.body);
      if (rawRecords.isNotEmpty) {
        for (dynamic record in rawRecords) {
          switch (instrument.getName()) {
            case "preop_data":
              if (record["preop_data_complete"] == "2") {
                instrument.addForm(
                    record['date_preop'], record['side_preop'], record);
              }
              break;
            case "postop_data":
              if (record["postop_data_complete"] == "2") {
                instrument.addForm(
                    record['date_preop'], record['side_preop'], record);
              }
              break;
            case "surgical_information":
              if (record["surgical_information_complete"] == "2") {
                instrument.addForm(
                    record['date_surgery'], record['side_surgery'], record);
              }
              break;
          }
        }
      }
    }
  } catch (e) {
    printError(e.toString());
  }
}
