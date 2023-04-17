class Choice {

  String number;
  String name;

  Choice(this.number, this.name);

  static Choice fromString(choiceString) {
    final p = choiceString.split(", ");
    return Choice(p[0], p[1]);
  }

  static Choice getChoiceByName(Set<Choice> choices, String name) {
    return choices.firstWhere((choice) => choice.name == name);
  }
}