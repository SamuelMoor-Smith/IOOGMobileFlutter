import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';

abstract class IOOGFieldWidgetState<String> extends FormFieldState<String> {
}

abstract class IOOGFieldWidget extends FormField<String> {
  final Field field;

  IOOGFieldWidget({
    Key? key,
    required this.field,
    required Widget Function(FormFieldState<String>) builder,
  }) : super(
          key: key,
          builder: (state) => builder(state),
        );

  Field getField() {
    return field;
  }

  String getFieldLabel() {
    return field.getFieldLabel();
  }

  String getFieldName() {
    return field.getFieldName();
  }

  String getFieldType() {
    return field.getFieldType();
  }

  bool isRequired() {
    return field.isRequired();
  }

  String getLabelText() {
    return field.getLabelText();
  }

  bool isFilled();
}