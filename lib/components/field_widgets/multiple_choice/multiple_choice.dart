import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';

import '../../../main.dart';
import '../../../models/choice.dart';
import '../../../models/instrument/instrument.dart';
import '../field_widget.dart';

abstract class IOOGMultipleChoice extends IOOGFieldWidget {

  final Set<Choice> choices;
  Set<Choice> selectedChoices = {};

  IOOGMultipleChoice ({ Key? key, required Field field, required Instrument instrument, required this.choices })
  : super(key: key, field: field, instrument: instrument);

  @override
  bool isFilled() {
    return choices.isNotEmpty;
  }

  Set<Choice> getSelectedChoices() {
    return selectedChoices;
  }

  Set<Choice> getChoices() {
    return choices;
  }

  selectChoice(Choice choice);
  unselectChoice(Choice choice);
  
  fillChoiceByNum(String choiceNum) {
    for (Choice choice in choices) {
      if (choice.number == choiceNum) {
        selectChoice(choice);
      }
    }
  }
}