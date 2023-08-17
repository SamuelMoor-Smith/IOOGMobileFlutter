import 'dart:convert';
import 'package:namer_app/utils/events.dart';
import 'package:namer_app/utils/logging.dart';

import '../../models/instrument.dart';

Map<String, String> createRepeatData(IOOGInstrument instrument) {
  Map<String, String> repeatData = {};
  printLog(instrument.getForms().toString());
  if (!instrument.isDemographic()) {
    repeatData['redcap_repeat_instrument'] = instrument.getName();
    if (instrument.getFormIndex() != null) {
      int formIndex = instrument.getFormIndex()!;
      var selectedRecord = instrument.getForms()[formIndex].getRecord();
      // Get the old repeat instance
      repeatData['redcap_repeat_instance'] =
          selectedRecord['redcap_repeat_instance'].toString();
    } else if (instrument.getForms().isNotEmpty) {
      // Just add one to the last repeat instance
      printLog(instrument.getForms().last.getRecord().toString());
      repeatData['redcap_repeat_instance'] =
          (instrument.getForms().last.getRecord()['redcap_repeat_instance'] + 1)
              .toString();
    } else {
      // The repeat instance is 1
      repeatData['redcap_repeat_instance'] = "1";
    }
  }
  printLog(repeatData.toString());
  return repeatData;
}

String createStudyIdPayload(IOOGInstrument instrument) {
  final formState = instrument.getFormManager().getFormStateNotifier().value;

  return jsonEncode([
    {
      'study_id': instrument.getProject().getActiveStudyId(),
      'redcap_event_name': formState.containsKey('redcap_event_name')
          ? formState['redcap_event_name']
          : getEventName(instrument),
      'study_id_complete': '2',
    },
  ]);
}

String createPayload(IOOGInstrument instrument) {
  final formState = instrument.getFormManager().getFormStateNotifier().value;

  final formStateCopy = Map.of(formState);
  // Remove the check groups keys
  formStateCopy.removeWhere((key, value) => key.endsWith('---'));

  Map<String, String> repeatData = createRepeatData(instrument);

  printLog(repeatData);
  printLog(formStateCopy);

  return jsonEncode([
    {
      'study_id': instrument.getProject().getActiveStudyId(),
      'redcap_event_name': formState.containsKey('redcap_event_name')
          ? formState['redcap_event_name']
          : getEventName(instrument),
      instrument.getCompleteKey(): '2',
      ...repeatData,
      ...formStateCopy,
    },
  ]);
}
