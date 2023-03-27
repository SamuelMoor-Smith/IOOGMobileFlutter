import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

abstract class IOOGFieldWidget extends StatefulWidget {

  final Field field;

  IOOGFieldWidget ({ Key? key, required this.field }): super(key: key);

  FormFieldValidator<String>? validator() {
    return isRequired()
        ? FormBuilderValidators.required(errorText: 'Please select an option')
        : null;
  }

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
  updateForm();
}