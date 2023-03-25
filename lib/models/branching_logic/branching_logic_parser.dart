import 'package:petitparser/petitparser.dart';

import 'expressions.dart';

class BranchingLogicParser {
  final Parser parser;

  BranchingLogicParser() : parser = _buildParser();

  static Parser _buildParser() {
    final builder = ExpressionBuilder();

    // Define field names and values
    final fieldName = (char('[') & letter().plus() & char(']')).flatten().trim();
    final value = (char('"') & any().starLazy(char('"')) & char('"')).flatten().trim();

    // Define field name and value comparison
    final comparison = (fieldName & (string('=') | string('>') | string('<') | string('>=') | string('<=') | string('<>')) & value).trim();

    // Define basic expressions
    builder.group()
      ..primitive(comparison)
      ..wrapper(char('(').trim(), char(')').trim(), (l, a, r) => a);

    // Define AND and OR expressions
    builder.group()
      ..left(string('and').trim(), (a, op, b) => AndExpression(a, b))
      ..left(string('or').trim(), (a, op, b) => OrExpression(a, b));

    return builder.build().end();
  }

  Expression parse(String input) {
    return parser.parse(input).value;
  }
}
