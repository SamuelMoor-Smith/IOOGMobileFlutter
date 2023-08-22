import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/logging.dart';

import '../../../models/choice.dart';
import '../field_widget.dart';

abstract class IOOGMultipleChoice extends IOOGFieldWidget {
  final Set<Choice> choices;
  Set<Choice> selectedChoices = {};
  final ValueNotifier<bool> selectedChoicesNotifier = ValueNotifier(false);

  IOOGMultipleChoice(
      {Key? key,
      required Field field,
      required FormManager formManager,
      required this.choices})
      : super(key: key, field: field, formManager: formManager);

  @override
  bool isFilled() {
    return selectedChoices.isNotEmpty;
  }

  // @override
  // validated() {
  //   return selectedChoices.isNotEmpty;
  // }

  Set<Choice> getSelectedChoices() {
    return selectedChoices;
  }

  Set<Choice> getChoices() {
    return choices;
  }

  selectChoice(Choice choice);
  unselectChoice(Choice choice);
  // buildChoices();

  fillChoiceByNum(String choiceNum) {
    for (Choice choice in choices) {
      if (choice.number == choiceNum) {
        selectChoice(choice);
        updateForm();
      }
    }
  }

  setDefaultChoice() {
    if (field.field_annotation.contains('@DEFAULT=')) {
      // Extract the default value from the annotation
      String defaultValue =
          field.field_annotation.split('=')[1].replaceAll('"', '');

      printLog('default value: $defaultValue');
      // Find the choice that corresponds to the default value
      Choice defaultChoice =
          choices.firstWhere((choice) => choice.number == defaultValue);

      // Select the default choice
      selectChoice(defaultChoice);
      updateForm();
    }
  }

  @override
  IOOGFieldWidgetState<IOOGFieldWidget> createState();
}

abstract class IOOGMultipleChoiceState<T extends IOOGMultipleChoice>
    extends IOOGFieldWidgetState<IOOGMultipleChoice> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Set the default choice (if any)
      widget.setDefaultChoice();
    });
  }
}
