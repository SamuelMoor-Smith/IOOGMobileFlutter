import 'dart:convert';
import 'package:namer_app/utils/events.dart';

import '../../models/instrument.dart';

String createPayload(IOOGInstrument instrument) {
  final formState = instrument.getFormKeyManager().getFormStateNotifier().value;

  final formStateCopy = Map.of(formState);
  // Remove the check groups keys
  formStateCopy.removeWhere((key, value) => key.endsWith('---'));

  return jsonEncode([
    {
      'study_id': instrument.getProject().getActiveStudyId()!,
      'redcap_event_name': getEventName(instrument),
      ...formStateCopy,
    },
  ]);
}
