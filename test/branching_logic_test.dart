// ignore_for_file: constant_identifier_names

import 'package:namer_app/models/branching_logic/branching_logic_parser.dart';
import 'package:test/test.dart';
import 'package:expressions/expressions.dart';

const AGE_OVER_30_UNPARSED = "[age] >= 30";
const AGE_OVER_30_PARSED = "age >= 30";

const GENDER_IS_MALE_UNPARSED = "[gender] = 'male'";
const GENDER_IS_MALE_PARSED = "gender == 'male'";

void main() {
  group('BranchingLogicParser', () {
    final parser = BranchingLogicParser();
    final evaluator = ExpressionEvaluator();

    test('Simple comparison', () {
      const input = AGE_OVER_30_UNPARSED;
      const expectedOutput = AGE_OVER_30_PARSED;
      final output = parser.parseBranchingLogic(input);
      expect(output, expectedOutput);

      final context = {
        'age': 35,
      };
      var expression = Expression.parse(output!);
      var r = evaluator.eval(expression, context);
      expect(r, true);
    });

    test('And expression', () {
      const input = "$AGE_OVER_30_UNPARSED and $GENDER_IS_MALE_UNPARSED";
      const expectedOutput = "$AGE_OVER_30_PARSED && $GENDER_IS_MALE_PARSED";
      final output = parser.parseBranchingLogic(input);
      expect(output, expectedOutput);

      final context = {
        'age': 35,
        'gender': 'female'
      };
      var expression = Expression.parse(output!);
      var r = evaluator.eval(expression, context);
      expect(r, false);
    });

    test('Or expression', () {
      const input = "$AGE_OVER_30_UNPARSED or $GENDER_IS_MALE_UNPARSED";
      const expectedOutput = "$AGE_OVER_30_PARSED || $GENDER_IS_MALE_PARSED";
      final output = parser.parseBranchingLogic(input);
      expect(output, expectedOutput);

      final context = {
        'age': 35,
        'gender': 'female'
      };
      var expression = Expression.parse(output!);
      var r = evaluator.eval(expression, context);
      expect(r, true);
    });

    test('Complex expression', () {
      const input = "[o_ossiculoplasty] = '3' or [o_ossiculoplasty] = '4' or [o_ossiculoplasty] = '5' or [o_ossiculoplasty] = '6' or [o_ossiculoplasty] = '7' or [o_ossiculoplasty] = '8' or [o_ossiculoplasty] = '9' or [o_ossiculoplasty] = '10'";
      const expectedOutput = "o_ossiculoplasty == '3' || o_ossiculoplasty == '4' || o_ossiculoplasty == '5' || o_ossiculoplasty == '6' || o_ossiculoplasty == '7' || o_ossiculoplasty == '8' || o_ossiculoplasty == '9' || o_ossiculoplasty == '10'";
      final output = parser.parseBranchingLogic(input);
      expect(output, expectedOutput);
    });

    test('Checkbox expression', () {
      const input = "[postop_complication(9)] = '1'";
      const expectedOutput = "postop_complication___9 == '1'";
      final output = parser.parseBranchingLogic(input);
      expect(output, expectedOutput);
    });

    test('Checkbox expression 2', () {
      const input = "[diagnosis(1)] = '1' or [diagnosis(2)] = '1' or [diagnosis(3)] = '1'";
      const expectedOutput = "diagnosis___1 == '1' || diagnosis___2 == '1' || diagnosis___3 == '1'";
      final output = parser.parseBranchingLogic(input);
      expect(output, expectedOutput);
    });
  });
}