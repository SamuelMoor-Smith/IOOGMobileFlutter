import '../field.dart';
import 'choice.dart';
import 'multiple_choice.dart';

class REDCapCheckButton extends MultipleChoice {
  
  Set<Choice> selectedChoices = {};

  REDCapCheckButton(Field field, Set<Choice> choices, this.selectedChoices) :
                
                  super(field, choices);

  selectChoice(Choice choice) {
    selectedChoices.add(choice);
  }

  unselectChoice(Choice choice) {
    selectedChoices.remove(choice);
  }
}