import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../models/instrument.dart';
import '../api_constants.dart';

Map<String, String> instrumentsBody() {
      return Map.of({
        "token": APIConstants.token!,
        "content": "instrument",
        "format": "json",
      });
    }

Future<List<Instrument>?> getInstruments() async {
    try {
      var url = Uri.parse(APIConstants.apiUrl!);
      var response = await http.post(
        url, 
        body: instrumentsBody(), 
        headers: APIConstants.headers());

      if (response.statusCode == 200) {
        return List<Instrument>.from(json.decode(response.body).map((raw) => Instrument(raw['instrument_name'], raw['instrument_label'])));
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }