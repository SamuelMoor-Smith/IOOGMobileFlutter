import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/models/project.dart';
import '../../models/instrument.dart';
import '../../utils/logging.dart';
import '../common.dart';

Map<String, String> instrumentsBody(IOOGProject project) {
  return Map.of({
    "token": project.token,
    "content": "instrument",
    "format": "json",
  });
}

Future<List<IOOGInstrument>> getInstrumentsForProjectFromREDCAP(
    IOOGProject project) async {
  try {
    var url = Uri.parse(project.apiUrl);
    var response = await http.post(
      url,
      body: instrumentsBody(project),
      headers: headers(),
    );

    if (response.statusCode == 200) {
      return List<IOOGInstrument>.from(json.decode(response.body).map((raw) =>
              IOOGInstrument(
                  project, raw['instrument_name'], raw['instrument_label'])))
          .toList(); // Retrieve all instruments for redcap project
    }
  } catch (e) {
    printError(e.toString());
  }
  return [];
}
