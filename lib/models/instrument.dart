import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Instrument {

  String name;
  String label;
  final formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<Map<String, String>> formStateNotifier = ValueNotifier<Map<String, String>>({});

  Instrument(this.name, this.label);
  
  GlobalKey<FormBuilderState> getFormKey() {
    return formKey;
  }

  ValueNotifier<Map<String, String>> getFormStateNotifier() {
    return formStateNotifier;
  }
}