// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'package:namer_app/main.dart';

import '../branching_logic/branching_logic_parser.dart';
import '../choice.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'field.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Field {

  late String field_name;
  late String form_name;
  late String section_header;
  late String field_type;
  late String field_label;
  late String select_choices_or_calculations;
  late String field_note;
  late String text_validation_type_or_show_slider_number;
  late String text_validation_min;
  late String text_validation_max;
  late String identifier;
  late String branching_logic;
  late String required_field;
  late String custom_alignment;
  late String question_number;
  late String matrix_group_name;
  late String matrix_ranking;
  late String field_annotation;

  Field(this.field_name,
        this.form_name,
        this.section_header,
        this.field_type,
        this.field_label,
        this.select_choices_or_calculations,
        this.field_note,
        this.text_validation_type_or_show_slider_number,
        this.text_validation_min,
        this.text_validation_max,
        this.identifier,
        this.branching_logic,
        this.required_field,
        this.custom_alignment,
        this.question_number,
        this.matrix_group_name,
        this.matrix_ranking,
        this.field_annotation,
  );

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$FieldToJson(this);

  // Set<Set<BranchingLogic>>? getBranchingLogic() {

  //   if (branching_logic == null) {
  //     return null;
  //   }

  //   List<String> orSplit = branching_logic.split(" or ");
  //   for (String or in orSplit) {
  //     Set<BranchingLogic> inner = {};
  //     List<String> andSplit = or.split(" and ");
  //     for (String and in andSplit) {
  //       List<String> logicSplit = and.split(" ");

  //       inner.add(BranchingLogic(this, comparison, value))
  //     }
  //   }
  // }

  // Fixing Data Functions

  Set<Choice> createChoices() {
    return Set<Choice>.from(select_choices_or_calculations.split(" | ").map((choiceString) => Choice.fromString(choiceString)));
  }

  // bool shouldShow() {
  //   BranchingLogicParser().parse(branching_logic).evaluate(formKey.currentState!.fields)
  // }

  String getFieldLabel() {
    return field_label;
  }

  String getFieldName() {
    return field_name;
  }

  String getFieldType() {
    return field_type;
  }

  bool isRequired() {
    return required_field == 'y';
  }

  String getLabelText() {
    if (isRequired()) {
      return '${getFieldLabel()}*:';
    } else {
      return '${getFieldLabel()}:';
    }
  }
}