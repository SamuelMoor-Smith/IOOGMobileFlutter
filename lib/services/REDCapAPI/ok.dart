import 'dart:developer';
import 'package:namer_app/utils.dart';

import 'api_constants.dart';

Map<String, String> okBody() {
  return Map.of({
    "token": APIConstants.token!,
    "content": "version",
    "format": "json",
  });
}

Future<bool> apiOK() async {
  try {
    var url = Uri.parse(APIConstants.apiUrl!);
    var http;
    var response =
        await http.post(url, body: okBody(), headers: APIConstants.headers());

    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    printError(e.toString());
  }
  return false;
}
