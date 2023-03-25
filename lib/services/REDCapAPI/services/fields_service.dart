import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/instrument.dart';
import '../../../models/field/field.dart';
import '../../utils/create_widgets.dart';
import '../../utils/fill_fields.dart';
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

Future<List<Widget?>?> getFields(Instrument instrument) async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: fieldsBody(instrument), 
        headers: APIConstants.headers()
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> rawFields = json.decode(response.body);
        List<Field> fields = rawFields.map((raw) => Field.fromJson(raw)).toList();
        return fields.map((field) => fieldWidget(field)).toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Widget?>?> fillFields(Instrument instrument, List<Widget> fieldWidgets) async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: fieldsFillBody(instrument), 
        headers: APIConstants.headers()
      );

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> rawRecords = json.decode(response.body);
        return fieldWidgets.map((fieldWidget) => fillField(fieldWidget, rawRecords[0])).toList();
      }
    } catch (e) {
      log(e.toString());
    }
  }