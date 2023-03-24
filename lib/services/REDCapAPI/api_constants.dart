import 'package:namer_app/models/app_field/instrument.dart';

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
}