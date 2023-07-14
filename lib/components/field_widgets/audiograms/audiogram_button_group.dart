import 'package:flutter/material.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/logging.dart';

class AudiogramButtonGroup extends ChangeNotifier {
  String field;
  ValueNotifier<String> audiogramValue = ValueNotifier<String>('');
  FormManager formManager;

  AudiogramButtonGroup(this.field, this.formManager);

  void setValue(String newValue) {
    audiogramValue.value = newValue;
    // formManager.updateForm(field, value);
  }
}
