import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';

import '../../../models/choice.dart';
import '../field_widget.dart';

abstract class IOOGMultipleChoiceState<String> extends IOOGFieldWidgetState {
}

abstract class IOOGMultipleChoice extends IOOGFieldWidget {

  final Set<Choice> choices;
  Set<Choice> selectedChoices = {};

  IOOGMultipleChoice ({ 
    Key? key,
    required this.choices,
    required Field field,
    required Widget Function(FormFieldState<String>) builder,
  }) : super(
          key: key,
          field: field,
          builder: builder,
        );

  @override
  bool isFilled() {
    return choices.isNotEmpty;
  }

  fillChoiceByNum(String choiceNum) {
    for (Choice choice in choices) {
      if (choice.number == choiceNum) {
        selectChoice(choice);
      }
    }
  }

  Set<Choice> getSelectedChoices() {
    return selectedChoices;
  }

  Set<Choice> getChoices() {
    return choices;
  }

  selectChoice(Choice choice);
  unselectChoice(Choice choice);
}