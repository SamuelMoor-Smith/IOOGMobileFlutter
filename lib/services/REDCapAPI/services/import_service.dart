import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';

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

Future<bool> import(Instrument instrument, List<Widget> fieldWidgets) async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);

    var data = createPayload(fieldWidgets);

    var response = await http.post(
      url, 
      body: importBody(data), 
      headers: APIConstants.headers()
    );

    return (response.statusCode == 200);
  } catch (e) {
    log(e.toString());
    return false;
  }
}