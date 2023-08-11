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

    var data = createPayload(instrument);

    var response = await http.post(url,
        body: importBody(project, data), headers: headers());

    if (response.statusCode == 200) {
      printLog(response.body);
      showImportToast();
      return true;
    } else {
      printLog(response.body);
      showImportErrorToast();
      return false;
    }
  } catch (e) {
    printError(e.toString());
    showImportErrorToast();
    return false;
  }
}
