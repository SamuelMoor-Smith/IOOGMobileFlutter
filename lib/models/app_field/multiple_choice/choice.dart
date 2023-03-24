class Choice {

  int number;
  String name;

  Choice(this.number, this.name);

  static Choice fromString(choiceString) {
    final p = choiceString.split(", ");
    return Choice(int.parse(p[0]), p[1]);
  }
}