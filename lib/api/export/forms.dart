import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/models/section.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../models/instrument.dart';
import '../../../../models/field/field.dart';
import '../../models/form.dart';
import '../../utils/logging.dart';
import '../common.dart';

Object recordBody(
    IOOGProject project, IOOGInstrument instrument, String studyId) {
  return Map.of({
    "apiToken": project.apiToken,
    "content": "record",
    "format": "json",
    "type": "flat",
    "forms[0]": instrument.getName(),
    "records[0]": studyId,
  });
}

IOOGForm? processRecordForInstrument(
    dynamic record, IOOGInstrument instrument) {
  switch (instrument.getName()) {
    case "basic_demography_form":
      if (record["basic_demography_form_complete"] == "2") {
        return IOOGForm('', '', record);
      }
      break;
    case "preop_data":
      if (record["preop_data_complete"] == "2") {
        return IOOGForm(record['date_preop'], record['side_preop'], record);
      }
      break;
    case "postop_data":
      if (record["postop_data_complete"] == "2") {
        return IOOGForm(record['date_postop'], record['side_postop'], record);
      }
      break;
    case "surgical_information":
      if (record["surgical_information_complete"] == "2") {
        return IOOGForm(record['date_surgery'], record['side_surgery'], record);
      }
      break;
  }
  return null;
}

Future<List<IOOGForm>?> getFormsForStudyIdAndInstrumentFromREDCAP(
    IOOGProject project, IOOGInstrument instrument, String studyId) async {
  try {
    var url = Uri.parse(project.apiUrl);
    var response = await http.post(url,
        body: recordBody(project, instrument, studyId), headers: headers());

    if (response.statusCode == 200) {
      List<dynamic> rawRecords = json.decode(response.body);

      List<IOOGForm> forms = [];
      for (dynamic record in rawRecords) {
        IOOGForm? formFromRecord =
            processRecordForInstrument(record, instrument);
        if (formFromRecord != null) {
          forms.add(formFromRecord);
        }
      }

      return forms;
    }
  } catch (e) {
    printError(e.toString());
  }
  return null;
}
