import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/services/form_key_manager.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils.dart';

abstract class IOOGFieldWidget extends StatefulWidget {
  final Field field;
  final FormKeyManager formKeyManager;
  bool shouldShow = true;

  IOOGFieldWidget({Key? key, required this.field, required this.formKeyManager})
      : super(key: key);

  FormFieldValidator<String>? validator() {
    if (shouldShow && isRequired()) {
      if (isFilled()) {
        return null;
      } else {
        return FormBuilderValidators.required(
            errorText: 'This field is required.');
      }
    } else {
      return null;
    }
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

  String getSectionHeader() {
    return field.getSectionHeader();
  }

  String getParsedBranchingLogic() {
    return field.getParsedBranchingLogic();
  }

  bool isFilled();
  void updateForm();
  void fillField(dynamic rawRecord);

  void checkBranchingLogic(setState) {
    String branchingLogic = field.getParsedBranchingLogic();
    if (!branchingLogic.isEmptyOrNull) {
      var expression = Expression.parse(branchingLogic);
      try {
        setState(() {
          shouldShow = formKeyManager.shouldShow(expression);
        });
      } catch (e) {
        printError("Error evaluating branching logic ${e.toString()}");
        printError(branchingLogic);
        printError(field.getFieldLabel());
      }
    }
  }
}
