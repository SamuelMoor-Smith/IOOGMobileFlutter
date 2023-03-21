import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:namer_app/components/check_button.dart';
import 'package:namer_app/components/radio_button.dart';
import 'package:namer_app/models/field.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';

import '../../components/comments_field.dart';
import '../../components/text_field.dart';
import '../../models/multiple_choice/check_group.dart';
import '../../models/multiple_choice/radio_button.dart';
import '../../models/text_field.dart';

Widget? fieldWidget(field) {
  switch (field.field_type) {
    case 'text':
      return IOOGTextFieldWidget(ioogTextField: IOOGTextField(field));
    case 'notes':
      return IOOGCommentsFieldWidget(ioogTextField: IOOGTextField(field));
    case 'radio':
      return IOOGRadioGroup(ioogMultipleChoiceRadioButton: IOOGMultipleChoiceRadioButton(field, field.createChoices(), null));
    case 'checkbox':
      return IOOGCheckGroup(ioogMultipleChoiceCheckButton: IOOGMultipleChoiceCheckButton(field, field.createChoices(), {}));
    default:
      return null;
  }
}

class ApiService {

  Future<bool> apiOK() async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: APIConstants.okBody(), 
        headers: APIConstants.headers());

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<List<Instrument>?> getInstruments() async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: APIConstants.instrumentsBody(), 
        headers: APIConstants.headers());

      debugPrint('Response status: ${response.statusCode}');
      debugPrint('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return List<Instrument>.from(json.decode(response.body).map((raw) => Instrument(raw['instrument_name'], raw['instrument_label'])));
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Widget?>?> getFields(Instrument instrument) async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: APIConstants.fieldsBody(instrument), 
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
}