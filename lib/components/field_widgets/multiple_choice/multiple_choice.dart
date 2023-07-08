import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../../models/choice.dart';
import '../field_widget.dart';

abstract class IOOGMultipleChoice extends IOOGFieldWidget {
  final Set<Choice> choices;
  Set<Choice> selectedChoices = {};

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
      }
    }
  }
}
