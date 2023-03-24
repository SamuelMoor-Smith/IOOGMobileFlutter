import '../field/field.dart';
import 'branching_logic.dart';

class BranchingLogicParser {
  final List<Field> fields;

  BranchingLogicParser(this.fields);

  List<BranchingLogic> parse(String branchingLogicStr) {
    final regex = RegExp(
      '\\[([^\\]]+)\\] *([=<>]+) *(?:\\\'|\\"|)([\\w]+)(?:\\\'|\\"|)',
    );
    final matches = regex.allMatches(branchingLogicStr);
    final branchingLogics = <BranchingLogic>[];

    for (final match in matches) {
      final fieldName = match.group(1);
      final comparison = match.group(2);
      final value = match.group(3);

      try {
        final field = _findField(fieldName);
        branchingLogics.add(BranchingLogic(field, comparison!, value!));
      } catch (e) {
        print('Error: $e');
      }
    }

    return branchingLogics;
  }

  Field _findField(String? fieldName) {
    if (fieldName == null) {
      throw ArgumentError('Invalid field name');
    }

    final field = fields.firstWhere(
      (f) => f.field_name == fieldName,
      orElse: () => throw ArgumentError('Field not found: $fieldName'),
    );

    return field;
  }
}
