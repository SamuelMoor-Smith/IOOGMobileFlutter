import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/text_styles.dart';
import 'package:namer_app/style/text/title_list_tile.dart';

import '../../../models/field/field.dart';
import '../../../models/choice.dart';
import '../field_widget.dart';

class IOOGCheckGroup extends IOOGMultipleChoice {
  IOOGCheckGroup({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
  }) : super(
            key: key, choices: choices, field: field, formManager: formManager);

  // @override
  // State<IOOGCheckGroup> createState() => _IOOGCheckGroup();

  @override
  selectChoice(Choice choice) {
    selectedChoices.add(choice);
  }

  @override
  unselectChoice(Choice choice) {
    selectedChoices.remove(choice);
  }

  @override
  fillField(dynamic rawRecord) {
    var fieldName = getFieldName();
    for (String name in rawRecord.keys) {
      if (name.startsWith(fieldName) && rawRecord[name] == "1") {
        fillChoiceByNum(name.split("___")[1]);
        updateForm();
      }
    }
  }

  @override
  void clearField() {
    selectedChoices = {};
  }

  @override
  updateForm() {
    for (Choice choice in choices) {
      var formFieldName = "${getFieldName()}___${choice.number}";
      if (selectedChoices.contains(choice)) {
        formManager.updateForm(formFieldName, "1");
      } else {
        formManager.updateForm(formFieldName, "0");
      }
    }
  }

  @override
  IOOGMultipleChoiceState<IOOGCheckGroup> createState() =>
      IOOGCheckGroupState();
}

class IOOGCheckGroupState<T extends IOOGCheckGroup>
    extends IOOGMultipleChoiceState<IOOGCheckGroup> {
  @override
  List<Widget> buildFieldWidgets() {
    return widget
        .getChoices()
        .map((choice) => ListTile(
              leading: Checkbox(
                value: widget.getSelectedChoices().contains(choice),
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null) {
                      value
                          ? widget.selectChoice(choice)
                          : widget.unselectChoice(choice);
                      widget.updateForm();
                    }
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
                  widget.updateForm();
                });
              },
            ))
        .toList();
  }
}
