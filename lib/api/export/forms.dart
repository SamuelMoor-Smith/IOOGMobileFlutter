import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/models/project.dart';
import '../../../../models/instrument.dart';
import '../../models/form.dart';
import '../../utils/logging.dart';
import '../common.dart';

Object recordBody(
    IOOGProject project, IOOGInstrument instrument, String studyId) {
  return Map.of({
    "token": project.token,
    "content": "record",
    "format": "json",
    "type": "flat",
    // "forms[0]": instrument.getName(),
    "records[0]": studyId,
  });
}

IOOGForm? processRecordForInstrument(
    dynamic record, IOOGInstrument instrument) {
  if (record[instrument.getCompleteKey()] == "2") {
    return IOOGForm(
        instrument.getDateKey() != null ? record[instrument.getDateKey()] : '',
        instrument.getSideKey() != null ? record[instrument.getSideKey()] : '',
        record);
  }
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
