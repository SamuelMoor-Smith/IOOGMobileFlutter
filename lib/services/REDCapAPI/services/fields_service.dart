import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/instrument/instrument.dart';
import '../../../models/field/field.dart';
import '../../utils/create_widgets.dart';
import '../api_constants.dart';

Object fieldsBody(Instrument instrument) {
      return Map.of({
        "token": APIConstants.token!,
        "content": "metadata",
        "format": "json",
        "forms[0]": instrument.name
      });
    }

Object fieldsFillBody(Instrument instrument) {
      return Map.of({
        "token": APIConstants.token!,
        "content": "record",
        "format": "json",
        "type": "flat",
        "forms[0]": instrument.name,
        "records[0]": APIConstants.studyId!,
      });
    }

Future<void> getFields(Instrument instrument) async {
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
      String? section;
      for (Field field in fields) {
        IOOGFieldWidget? fieldWidgetInstance = fieldWidget(field, instrument);
        if (fieldWidgetInstance != null) {
          if (!fieldWidgetInstance.getSectionHeader().isEmptyOrNull) {
            section = fieldWidgetInstance.getSectionHeader();
          }
          instrument.addFieldWidget(fieldWidgetInstance, section);
        }
      }
    }
  } catch (e) {
    log(e.toString());
  }
}

Future<void> fillFields(Instrument instrument) async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);
    var response = await http.post(
      url, 
      body: fieldsFillBody(instrument), 
      headers: APIConstants.headers()
    );

    if (response.statusCode == 200) {
      List<dynamic> rawRecords = json.decode(response.body);
      if (rawRecords.isNotEmpty) {
        instrument.getAllFieldWidgets().forEach((fieldWidget) => fieldWidget.fillField(rawRecords[0]));
      }
    }
  } catch (e) {
    log(e.toString());
  }
}

Future<void> fillFieldsFromRecord(Instrument instrument, dynamic record) async {
  try {
    instrument.getAllFieldWidgets().forEach((fieldWidget) => fieldWidget.fillField(record));
  } catch (e) {
    log(e.toString());
  }
}

Future<void> fillForms(Instrument instrument) async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: fieldsFillBody(instrument), 
        headers: APIConstants.headers()
      );

      if (response.statusCode == 200) {
        List<dynamic> rawRecords = json.decode(response.body);
        if (rawRecords.isNotEmpty) {
          for (dynamic record in rawRecords) {
            switch (instrument.name) {
              case "preop_data":
                if (record["preop_data_complete"] == "2") {
                  instrument.addForm(record['date_preop'], record['side_preop'], record);
                }
                break;
              case "postop_data":
                if (record["postop_data_complete"] == "2") {
                  instrument.addForm(record['date_preop'], record['side_preop'], record);
                }
                break;
              case "surgical_information":
                if (record["surgical_information_complete"] == "2") {
                  instrument.addForm(record['date_surgery'], record['side_surgery'], record);
                }
                break;
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }