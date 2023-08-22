import 'package:http/http.dart' as http;
import 'package:namer_app/components/import_toast.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/models/project.dart';
import '../../utils/create_import.dart';
import '../../utils/logging.dart';
import '../common.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

Object importBody(IOOGProject project, data) {
  return Map.of({
    'token': project.token,
    'content': 'record',
    'format': 'json',
    'type': 'flat',
    'overwriteBehavior': 'normal',
    'forceAutoNumber': 'false',
    'data': data,
  });
}

Future<bool> importToREDCAP(
    IOOGProject project, IOOGInstrument instrument) async {
  try {
    var url = Uri.parse(project.apiUrl);

    var studyIdData = createStudyIdPayload(instrument);
    var data = createPayload(instrument);

    // Create the futures for the two requests
    var studyIdRequest = http.post(url,
        body: importBody(project, studyIdData), headers: headers());

    var dataRequest =
        http.post(url, body: importBody(project, data), headers: headers());

    // Wait for both requests to complete
    var responses = await Future.wait([studyIdRequest, dataRequest]);

    // Check the status code of the second request (you can also check the first one if needed)
    if (responses[1].statusCode == 200) {
      instrument.setForms();
      showImportToast();
      return true;
    } else {
      printLog(responses[1].body);
      showImportErrorToast(responses[1].body);
      return false;
    }
  } catch (e) {
    printError(e.toString());
    showImportErrorToast(e.toString());
    return false;
  }
}
