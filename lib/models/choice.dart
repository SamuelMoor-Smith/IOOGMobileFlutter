import 'package:namer_app/utils/logging.dart';

class Choice {
  String number;
  String name;

  Choice(this.number, this.name);

  // static Choice fromString(choiceString) {
  //   final p = choiceString.split(", ");
  //   return Choice(p[0], p[1]);
  // }

  static Choice fromString(choiceString) {
    final RegExp pattern = RegExp(r'(\d+), (.*)');
    final Match match = pattern.firstMatch(choiceString)!;
    return Choice(match.group(1)!, match.group(2)!);
  }

  static Choice getChoiceByName(Set<Choice> choices, String name) {
    try {
      return choices.firstWhere((choice) => choice.name == name);
    } catch (e) {
      printError("Choice not found: $name");
      return Choice("", "");
    }
  }
}
