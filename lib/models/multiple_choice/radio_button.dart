import 'package:namer_app/models/field.dart';

import 'choice.dart';
import 'multiple_choice.dart';

class IOOGMultipleChoiceRadioButton extends IOOGMultipleChoice {
  
  Choice? selectedChoice;

  IOOGMultipleChoiceRadioButton(Field field, Set<Choice> choices, this.selectedChoice) :
                
                  super(field, choices);

  selectChoice(Choice? choice) {
    selectedChoice = choice;
  }
}