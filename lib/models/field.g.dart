// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      json['field_name'] as String,
      json['form_name'] as String,
      json['section_header'] as String,
      json['field_type'] as String,
      json['field_label'] as String,
      json['select_choices_or_calculations'] as String,
      json['field_note'] as String,
      json['text_validation_type_or_show_slider_number'] as String,
      json['text_validation_min'] as String,
      json['text_validation_max'] as String,
      json['identifier'] as String,
      json['branching_logic'] as String,
      json['required_field'] as String,
      json['custom_alignment'] as String,
      json['question_number'] as String,
      json['matrix_group_name'] as String,
      json['matrix_ranking'] as String,
      json['field_annotation'] as String,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'field_name': instance.field_name,
      'form_name': instance.form_name,
      'section_header': instance.section_header,
      'field_type': instance.field_type,
      'field_label': instance.field_label,
      'select_choices_or_calculations': instance.select_choices_or_calculations,
      'field_note': instance.field_note,
      'text_validation_type_or_show_slider_number':
          instance.text_validation_type_or_show_slider_number,
      'text_validation_min': instance.text_validation_min,
      'text_validation_max': instance.text_validation_max,
      'identifier': instance.identifier,
      'branching_logic': instance.branching_logic,
      'required_field': instance.required_field,
      'custom_alignment': instance.custom_alignment,
      'question_number': instance.question_number,
      'matrix_group_name': instance.matrix_group_name,
      'matrix_ranking': instance.matrix_ranking,
      'field_annotation': instance.field_annotation,
    };
