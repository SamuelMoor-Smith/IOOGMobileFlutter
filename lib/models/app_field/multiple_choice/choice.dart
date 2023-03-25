class Choice {

  String number;
  String name;

  Choice(this.number, this.name);

  static Choice fromString(choiceString) {
    final p = choiceString.split(", ");
    return Choice(p[0], p[1]);
  }
}