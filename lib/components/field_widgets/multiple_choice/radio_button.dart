import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/text_styles.dart';
import 'package:namer_app/utils/logging.dart';

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
  void updateChoice() {
    if (mounted) {
      setState(() {
        if (widget.formManager
            .getFormStateNotifier()
            .value
            .containsKey(widget.field.field_name)) {
          var newNum = widget.formManager
              .getFormStateNotifier()
              .value[widget.field.field_name];
          printLog(newNum);
          if (newNum != null && newNum != "") {
            if (widget.getSelectedChoices().isEmpty ||
                widget.getSelectedChoices().first.number != newNum) {
              printLog(newNum);
              widget.fillChoiceByNum(newNum);
            }
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.field.field_name == "audiogram_timing") {
      widget.formManager
          .getFormStateNotifier()
          .addListener(() => updateChoice());
    }
  }

  @override
  List<Widget> buildFieldWidgets() {
    return widget
        .getChoices()
        .map((choice) => ListTile(
              leading: Radio<Choice>(
                value: choice,
                groupValue: widget.getSelectedChoices().isEmpty
                    ? null
                    : widget.getSelectedChoices().first,
                onChanged: (Choice? value) {
                  setState(() {
                    if (widget.getSelectedChoices().contains(value)) {
                      widget.unselectChoice(value!);
                    } else {
                      widget.selectChoice(value!);
                    }
                    printLog(widget.getSelectedChoices().toString());
                    widget.updateForm();
                  });
                },
              ),
              title: Text(
                choice.name,
                style: primaryTextStyle(),
              ),
              visualDensity: VisualDensity(vertical: -4),
              onTap: () {
                setState(() {
                  if (widget.getSelectedChoices().contains(choice)) {
                    widget.unselectChoice(choice);
                  } else {
                    widget.selectChoice(choice);
                  }
                  printLog(widget.getSelectedChoices().toString());
                  widget.updateForm();
                });
              },
            ))
        .toList();
  }
}
