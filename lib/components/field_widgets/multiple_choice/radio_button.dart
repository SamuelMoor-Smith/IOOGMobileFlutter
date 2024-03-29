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
    String? defaultChoiceNumber,
  }) : super(
            key: key,
            choices: choices,
            field: field,
            formManager: formManager) {
    if (defaultChoiceNumber != null) {
      // fillChoiceByNum(defaultChoiceNumber);
      // printLog(selectedChoices.first.number);
    }
  }

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
    printLog("Filling field ${getFieldName()}");
    var fieldName = getFieldName();
    if (rawRecord.containsKey(fieldName)) {
      printLog('with value ${rawRecord[fieldName]}');
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
          if (newNum != null && newNum != "") {
            if (widget.getSelectedChoices().isEmpty ||
                widget.getSelectedChoices().first.number != newNum) {
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
    if (widget.field.field_name == "audiogram_timing" ||
        widget.field.field_annotation.contains('@DEFAULT=')) {
      widget.formManager
          .getFormStateNotifier()
          .addListener(() => updateChoice());
    }
  }

  void _handleTap(Choice choice) {
    setState(() {
      if (widget.getSelectedChoices().contains(choice)) {
        widget.unselectChoice(choice);
      } else {
        widget.selectChoice(choice);
      }
      widget.updateForm();
    });
  }

  @override
  List<Widget> buildFieldWidgets() {
    return widget
        .getChoices()
        .map((choice) => GestureDetector(
              onTap: () {
                _handleTap(choice);
              },
              child: ListTile(
                leading: Radio<Choice>(
                  value: choice,
                  groupValue: widget.getSelectedChoices().isEmpty
                      ? null
                      : widget.getSelectedChoices().first,
                  onChanged: (Choice? value) {
                    _handleTap(choice);
                  },
                ),
                title: Text(
                  choice.name,
                  style: primaryTextStyle(),
                ),
                visualDensity: VisualDensity(vertical: -4),
              ),
            ))
        .toList();
  }
}
