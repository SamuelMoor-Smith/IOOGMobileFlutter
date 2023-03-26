import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';

abstract class IOOGFieldWidget extends StatefulWidget {

  final Field field;

  IOOGFieldWidget ({ Key? key, required this.field }): super(key: key);

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