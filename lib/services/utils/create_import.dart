import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';

import '../../models/instrument.dart';

String createPayload(IOOGInstrument instrument) {
  final formState = instrument.getFormKeyManager().getFormStateNotifier().value;
  return jsonEncode([
    {
      'study_id': APIConstants.studyId!,
      'redcap_event_name': 'value1',
      'field2': 'value2',
      'field3': 'value3',
    },
  ]);
}
