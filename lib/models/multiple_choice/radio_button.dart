import 'package:namer_app/models/field.dart';

import 'choice.dart';
import 'multiple_choice.dart';

class REDCapRadioButton extends MultipleChoice {
  
  Choice? selectedChoice;

  REDCapRadioButton(Field field, Set<Choice> choices, this.selectedChoice) :
                
                  super(field, choices);

  selectChoice(Choice? choice) {
    selectedChoice = choice;
  }
}