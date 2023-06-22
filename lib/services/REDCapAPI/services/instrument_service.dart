import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../models/instrument.dart';
import '../../../utils.dart';
import '../api_constants.dart';

Map<String, String> instrumentsBody() {
  return Map.of({
    "token": APIConstants.token!,
    "content": "instrument",
    "format": "json",
  });
}

Future<List<IOOGInstrument>> getInstruments() async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);
    var response = await http.post(
      url,
      body: instrumentsBody(),
      headers: APIConstants.headers(),
    );

    if (response.statusCode == 200) {
      return List<IOOGInstrument>.from(json
          .decode(response.body)
          .map((raw) =>
              IOOGInstrument(raw['instrument_name'], raw['instrument_label']))
          .where((dynamic instrument) =>
              (instrument is IOOGInstrument) &&
              instrument.getLabel() != "Study ID" 
              && instrument.getLabel() != "Phenx Audiogram Hearing Test"
              )).toList();
    }
  } catch (e) {
    printError(e.toString());
  }
  return [];
}
