import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/check_button.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/utils/logging.dart';

import '../components/field_widgets/field_widget.dart';
import '../main.dart';
import '../models/choice.dart';
import '../models/section.dart';

class FormManager {
  ValueNotifier<Map<String, String>> _formStateNotifier =
      ValueNotifier<Map<String, String>>({});

  // Keys SHOULD NOT CHANGE
  void setInitialFormState(IOOGInstrument instrument) async {
    List<IOOGFieldWidget> fieldWidgets = await instrument.getAllFieldWidgets();
    for (IOOGFieldWidget fieldWidget in fieldWidgets) {
      // For audiograms the fiels names include the ear
      // For check buttons the field name includes the choice
      if (fieldWidget is IOOGCheckGroup) {
        setInitialStateForCheckGroup(fieldWidget);
      } else {
        // Otherwise it is just the name
        _formStateNotifier.value[fieldWidget.getFieldName()] = "";
      }
    }
  }

  void setInitialStateForCheckGroup(IOOGCheckGroup fieldWidget) {
    for (Choice choice in fieldWidget.getChoices()) {
      var formFieldName = "${fieldWidget.getFieldName()}___${choice.number}";
      _formStateNotifier.value[formFieldName] = "";
    }
  }

  ValueNotifier<Map<String, String>> getFormStateNotifier() {
    return _formStateNotifier;
  }

  // void regenerateFormKeyAndNotifier() {
  //   _formKey.currentState?.reset();
  //   _formStateNotifier.value = {};
  // }

  // void saveForm() {
  //   if (!currentStateExists()) {
  //     return;
  //   }
  //   _formKey.currentState?.save();
  // }

  bool shouldShow(Expression? expression) {
    // return true;
    if (expression == null) {
      return true;
    }
    return evaluator.eval(expression, _formStateNotifier.value);
  }

  void updateForm(String formFieldName, String? newValue) {
    // Check if the formFieldName exists
    if (!_formStateNotifier.value.containsKey(formFieldName)) {
      printError("no key $formFieldName in the state - shouldnt happen");
      return;
    }

    // Clone the current map, change the value, and assign the new map to the ValueNotifier
    var updatedMap = Map<String, String>.from(_formStateNotifier.value);
    updatedMap[formFieldName] = newValue ?? "";
    _formStateNotifier.value = updatedMap;
  }

  void updateAllFormFields(List<IOOGFieldWidget> fieldWidgets) {
    printLog("updating all form fields");

    // Update all form fields
    for (IOOGFieldWidget fieldWidget in fieldWidgets) {
      fieldWidget.updateForm();
    }
  }

  bool sectionIsValid(IOOGSection section) {
    // Check if form is valid
    printLog("Validation check");
    bool isSectionValid = true;
    for (IOOGFieldWidget fieldWidget in section.getFields()) {
      if (fieldWidget.isValid() != null) {
        printError(fieldWidget.isValid()!);
        isSectionValid = false;
      }
    }
    return isSectionValid;
  }

  // bool currentStateExists() {
  //   // if (_formKey.currentState == null) {
  //   //   printError("current state is null");
  //   //   return false;
  //   // }
  //   return true;
  // }
}