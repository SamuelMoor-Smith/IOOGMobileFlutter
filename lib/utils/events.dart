import 'package:namer_app/models/instrument.dart';

String getEventName(IOOGInstrument instrument) {
  switch (instrument.getName()) {
    case "basic_demography_form":
      return "demography_form_arm_1";
    case "preop_data":
      return "preop_status_arm_1";
    case "postop_data":
      return "postop_status_arm_1";
    case "surgical_information":
      return "operation_arm_1";
    default:
      return "";
  }
}
