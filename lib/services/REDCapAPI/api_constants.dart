import 'package:namer_app/models/instrument.dart';

class APIConstants {

    static String? apiUrl;
    static String? token;
    static String? studyId;

    static Map<String, String> headers() {
      return Map.of({
        "Content-Type": "application/x-www-form-urlencoded",
        "charset": "UTF-8"
      });
    }

    static Map<String, String> okBody() {
      return Map.of({
        "token": APIConstants.token!,
        "content": "version",
        "format": "json",
      });
    }

    static Map<String, String> instrumentsBody() {
      return Map.of({
        "token": APIConstants.token!,
        "content": "instrument",
        "format": "json",
      });
    }

    static Object fieldsBody(Instrument instrument) {
      return Map.of({
        "token": APIConstants.token!,
        "content": "metadata",
        "format": "json",
        "forms[0]": instrument.name
      });
    }

    static Object fieldsFillBody(Instrument instrument) {
      return Map.of({
        "token": APIConstants.token!,
        "content": "record",
        "format": "json",
        "type": "flat",
        "forms[0]": instrument.name,
        "records[0]": APIConstants.studyId!,
      });
    }
}