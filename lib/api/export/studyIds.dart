import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:namer_app/models/project.dart';
import '../../utils/logging.dart';
import '../common.dart';

Object studyIdsBody(IOOGProject project) {
  return Map.of({
    "token": project.token,
    "content": "record",
    "format": "json",
    "type": "flat",
    "fields[0]": 'study_id'
  });
}

Future<List<String>?> getStudyIdsForProjectFromREDCAP(
    IOOGProject project) async {
  try {
    var url = Uri.parse(project.apiUrl);
    var response =
        await http.post(url, body: studyIdsBody(project), headers: headers());

    if (response.statusCode == 200) {
      List<dynamic> record = json.decode(response.body);
      Set<String> uniqueStudyIds = {};
      for (var item in record) {
        uniqueStudyIds.add(item['study_id']);
      }
      return uniqueStudyIds.toList();
    }
  } catch (e) {
    printError(e.toString());
  }
  return null;
}
