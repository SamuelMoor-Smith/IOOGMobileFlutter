import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';

import '../field_widget.dart';

abstract class IOOGTextWidget extends IOOGFieldWidget {

  String enteredText = "";

  IOOGTextWidget ({ 
    Key? key,
    required Field field,
    required Widget Function(FormFieldState<String>) builder,
  }) : super(
          key: key,
          field: field,
          builder: builder,
        );

  @override
  bool isFilled() {
    return enteredText.isNotEmpty;
  }

  setEnteredText(String text) {
    enteredText = text;
  }

  String getEnteredText() {
    return enteredText;
  }
}