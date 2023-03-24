import 'dart:convert';
import 'package:flutter/material.dart';

String createPayload(List<Widget> fieldWidgets) {
  return jsonEncode([
    {
      'record_id': '001',
      'field1': 'value1',
      'field2': 'value2',
      'field3': 'value3',
    },
  ]);
}