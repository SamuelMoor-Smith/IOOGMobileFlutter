import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../style/text/title_list_tile.dart';
import '../field_widget.dart';

class IOOGRadioGroup extends IOOGMultipleChoice {
  IOOGRadioGroup({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
  }) : super(
            key: key, choices: choices, field: field, formManager: formManager);

  // @override
  // validated() {
  //   return selectedChoices.isNotEmpty;
  // }

  @override
  selectChoice(Choice choice) {
    selectedChoices.removeAll(choices); // Only 1 choice can be selected
    selectedChoices.add(choice);
  }

  @override
  unselectChoice(Choice choice) {
    selectedChoices.remove(choice);
  }

  @override
  fillField(dynamic rawRecord) {
    var fieldName = getFieldName();
    if (rawRecord.containsKey(fieldName)) {
      fillChoiceByNum(rawRecord[fieldName]!);
    }
  }

  @override
  void clearField() {
    selectedChoices = {};
  }

  @override
  updateForm() {
    if (selectedChoices.isNotEmpty) {
      formManager.updateForm(getFieldName(), selectedChoices.first.number);
    } else {
      formManager.updateForm(getFieldName(), '');
    }
  }

  @override
  IOOGMultipleChoiceState<IOOGRadioGroup> createState() =>
      IOOGRadioGroupState();
}

class IOOGRadioGroupState<T extends IOOGRadioGroup>
    extends IOOGMultipleChoiceState<IOOGRadioGroup> {
  @override
  List<Widget> buildFieldWidgets() {
    return widget
        .getChoices()
        .map((choice) => RadioListTile<Choice>(
            title: Text(
              choice.name,
              style: primaryTextStyle(),
            ),
            value: choice,
            groupValue: widget.getSelectedChoices().isEmpty
                ? null
                : widget
                    .getSelectedChoices()
                    .first, // Only ever 1 choice selected
            onChanged: (Choice? value) {
              setState(() {
                widget.selectChoice(value!);
                widget.updateForm();
              });
            },
            visualDensity: VisualDensity(vertical: -4)))
        .toList();
  }
}
