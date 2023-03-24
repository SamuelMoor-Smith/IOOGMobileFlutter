import 'package:namer_app/models/branching_logic/branching_logic.dart';

import '../../field/field.dart';
import 'choice.dart';

class IOOGMultipleChoice {
  
  Field field;
  Set<Choice> choices;

  IOOGMultipleChoice(this.field, this.choices);

}