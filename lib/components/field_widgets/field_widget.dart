import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';

abstract class IOOGFieldWidget extends StatefulWidget {

  final Field field;

  IOOGFieldWidget ({ Key? key, required this.field }): super(key: key);

  Field getField() {
    return field;
  }

  String getFieldLabel() {
    return field.field_label;
  }

  String getFieldName() {
    return field.field_name;
  }

  String getFieldType() {
    return field.field_type;
  }

  bool isRequired() {
    return field.required_field == 'y';
  }

  String getLabelText() {
    if (isRequired()) {
      return '${getFieldLabel()}*:';
    } else {
      return '${getFieldLabel()}:';
    }
  }

  bool isFilled();
}