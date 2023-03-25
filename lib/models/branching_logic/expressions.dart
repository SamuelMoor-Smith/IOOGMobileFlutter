abstract class Expression {
  bool evaluate(Map<String, String> fieldValues);
}

class AndExpression implements Expression {
  final Expression left;
  final Expression right;

  AndExpression(this.left, this.right);

  @override
  bool evaluate(Map<String, String> fieldValues) {
    return left.evaluate(fieldValues) && right.evaluate(fieldValues);
  }
}

class OrExpression implements Expression {
  final Expression left;
  final Expression right;

  OrExpression(this.left, this.right);

  @override
  bool evaluate(Map<String, String> fieldValues) {
    return left.evaluate(fieldValues) || right.evaluate(fieldValues);
  }
}

class Comparison implements Expression {
  final String fieldName;
  final String operator;
  final String value;

  Comparison(this.fieldName, this.operator, this.value);

  @override
  bool evaluate(Map<String, String> fieldValues) {
    final fieldValue = fieldValues[fieldName];
    if (fieldValue == null) return false;

    switch (operator) {
      case '=':
        return fieldValue == value;
      case '>':
        return num.parse(fieldValue) > num.parse(value);
      case '<':
        return num.parse(fieldValue) < num.parse(value);
      case '>=':
        return num.parse(fieldValue) >= num.parse(value);
      case '<=':
        return num.parse(fieldValue) <= num.parse(value);
      case '<>':
        return fieldValue != value;
      default:
        return false;
    }
  }
}
