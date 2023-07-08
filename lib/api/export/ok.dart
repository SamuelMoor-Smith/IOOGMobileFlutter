import 'package:namer_app/models/project.dart';
import 'package:namer_app/utils/logging.dart';
import 'package:http/http.dart' as http;
import '../common.dart';

Map<String, String> okBody(IOOGProject project) {
  return Map.of({
    "token": project.token,
    "content": "version",
    "format": "json",
  });
}

Future<bool> getOKFromREDCAP(IOOGProject project) async {
  try {
    var url = Uri.parse(project.apiUrl);
    var response =
        await http.post(url, body: okBody(project), headers: headers());

    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    printError(e.toString());
  }
  return false;
}
