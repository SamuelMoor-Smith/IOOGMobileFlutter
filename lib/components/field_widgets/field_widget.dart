import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

abstract class IOOGFieldWidget extends StatefulWidget {

  final Field field;
  final Instrument instrument;
  bool shouldShow = true;

  IOOGFieldWidget ({ Key? key, required this.field, required this.instrument }): super(key: key);

  FormFieldValidator<String>? validator() {
    if (shouldShow && isRequired()) {
      if (isFilled()) {
        return null;
      } else {
        return FormBuilderValidators.required(errorText: 'This field is required.');
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

  GlobalKey<FormBuilderState> getFormKey() {
    return instrument.getFormKey();
  }

  ValueNotifier<Map<String, String>> getFormStateNotifier() {
    return instrument.getFormStateNotifier();
  }

  bool isFilled();
  void updateForm();
  void fillField(dynamic rawRecord);

  updateFormState() {
    debugPrint(getFormKey().currentState!.fields.toString());
    getFormStateNotifier().value = getFormKey().currentState!.fields.map<String, String>(
      (key, fieldState) => MapEntry(key, fieldState.value.toString()),
    );
  }

  void checkBranchingLogic(setState) {
    String branchingLogic = field.getParsedBranchingLogic();
    if (!branchingLogic.isEmptyOrNull) {
      var expression = Expression.parse(branchingLogic);
      try {
        setState(() {
          shouldShow = evaluator.eval(expression, getFormStateNotifier().value);
        });
      } catch (e) {
        debugPrint(branchingLogic);
        debugPrint(field.getFieldLabel());
        debugPrint(e.toString());
      }
    }
  }
}