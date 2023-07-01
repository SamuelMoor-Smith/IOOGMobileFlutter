import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/services/REDCapAPI/services/event_service.dart';
import 'package:namer_app/utils.dart';

import '../../models/instrument.dart';

String createPayload(IOOGInstrument instrument) {
  final formState = instrument.getFormKeyManager().getFormStateNotifier().value;
  
  final formStateCopy = Map.of(formState);
  // Remove the check groups keys
  formStateCopy.removeWhere((key, value) => key.endsWith('---'));

  return jsonEncode([
    {
      'study_id': APIConstants.studyId!,
      'redcap_event_name': getEventName(instrument),
      ...formStateCopy,
    },
  ]);
}
