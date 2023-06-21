import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';

import '../../../utils.dart';
import '../../utils/create_import.dart';

Object importBody(data) {
  return Map.of({
    'token': APIConstants.token!,
    'content': 'record',
    'format': 'json',
    'type': 'flat',
    'overwriteBehavior': 'normal',
    'forceAutoNumber': 'false',
    'data': data,
  });
}

Future<bool> import(IOOGInstrument instrument) async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);

    var data = createPayload(instrument);

    var response = await http.post(url,
        body: importBody(data), headers: APIConstants.headers());

    if (response.statusCode == 200) {
      printLog(response.body);
      return true;
    } else {
      printLog(response.body);
      return false;
    }
  } catch (e) {
    printError(e.toString());
    return false;
  }
}
