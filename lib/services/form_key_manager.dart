import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../components/field_widgets/field_widget.dart';
import '../main.dart';

class FormKeyManager {
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<Map<String, String>> _formStateNotifier =
      ValueNotifier<Map<String, String>>({});

  // Getters for variables
  GlobalKey<FormBuilderState> getFormKey() {
    return _formKey;
  }

  ValueNotifier<Map<String, String>> getFormStateNotifier() {
    return _formStateNotifier;
  }

  void regenerateFormKeyAndNotifier() {
    _formKey = GlobalKey<FormBuilderState>();
    _formStateNotifier.value = {};
  }

  bool shouldShow(Expression? expression) {
    if (expression == null) {
      return true;
    }
    return evaluator.eval(expression, _formStateNotifier.value);
  }

  void updateForm(String formFieldName, String? newValue) {
    if (!currentStateExists()) {
      return;
    }

    // Check if the formFieldName exists
    final formFields = _formKey.currentState!.fields;
    if (!formFields.containsKey(formFieldName)) {
      print("no key $formFieldName in the state");
      return;
    }

    // Change the value
    formFields[formFieldName]!.didChange(newValue);
    // Save the state
    _formKey.currentState!.save();
    // Update the notifier
    _formStateNotifier.value =
        _formKey.currentState!.fields.map<String, String>(
      (key, fieldState) => MapEntry(key, fieldState.value.toString()),
    );
  }

  void updateAllFormFields(List<IOOGFieldWidget> fieldWidgets) {
    if (!currentStateExists()) {
      return;
    }

    // Update all form fields
    for (IOOGFieldWidget fieldWidget in fieldWidgets) {
      fieldWidget.updateForm();
    }
  }

  bool formIsValid() {
    if (!currentStateExists()) {
      return false;
    }

    // Check if form is valid
    bool isFormValid = _formKey.currentState!.validate();
    if (!isFormValid) {
      _formKey.currentState!.fields.forEach((fieldName, field) {
        if (!field.validate()) {
          debugPrint(
              'Field "$fieldName" had validation with message: ${field.validate()}');
        }
      });
    }
    return isFormValid;
  }

  bool currentStateExists() {
    if (_formKey.currentState == null) {
      debugPrint("current state is null");
      return false;
    }
    return true;
  }
}
