import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/utils.dart';

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
    _formKey.currentState?.reset();
    _formStateNotifier.value = {};
  }

  void saveForm() {
    if (!currentStateExists()) {
      return;
    }
    _formKey.currentState?.save();
  }

  bool shouldShow(Expression? expression) {
    // return true;
    if (expression == null) {
      return true;
    }
    return evaluator.eval(expression, _formStateNotifier.value);
  }

  void updateForm(String formFieldName, String? newValue) {
    if (!currentStateExists()) {
      return;
    }

    printLog(formFieldName);
    // Check if the formFieldName exists
    final formFields = _formKey.currentState!.fields;
    if (!formFields.containsKey(formFieldName)) {
      print(formFieldName);
      print(formFields.keys.toList());
      printError("no key $formFieldName in the state");
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

    printLog("update all form fields");

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
          printError(
              "Field $fieldName had validation error: ${field.validate()}");
        }
      });
    }
    return isFormValid;
  }

  bool currentStateExists() {
    if (_formKey.currentState == null) {
      printError("current state is null");
      return false;
    }
    return true;
  }
}
