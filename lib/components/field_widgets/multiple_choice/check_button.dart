import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/text_styles.dart';
import 'package:namer_app/style/text/title_list_tile.dart';

import '../../../models/field/field.dart';
import '../../../models/choice.dart';

class IOOGCheckGroup extends IOOGMultipleChoice {
  IOOGCheckGroup({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
  }) : super(
            key: key, choices: choices, field: field, formManager: formManager);

  @override
  State<IOOGCheckGroup> createState() => _IOOGCheckGroup();

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
}

class _IOOGCheckGroup extends State<IOOGCheckGroup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkBranchingLogic(setState, mounted);
      // Set the default choice (if any)
      widget.setDefaultChoice();
    });
    widget.formManager
        .getFormStateNotifier()
        .addListener(() => widget.checkBranchingLogic(setState, mounted));
  }

  @override
  void dispose() {
    widget.formManager
        .getFormStateNotifier()
        .removeListener(() => widget.checkBranchingLogic(setState, mounted));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.shouldShow,
      child: FieldContainer(
          child: Column(children: [
        TitleListTile(
            labelText: widget.getLabelText(),
            fieldNote: widget.field.field_note),
        ...widget
            .getChoices()
            .map((choice) => CheckboxListTile(
                title: Text(
                  choice.name,
                  style: primaryTextStyle(),
                ),
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
                controlAffinity: ListTileControlAffinity.leading,
                visualDensity: VisualDensity(vertical: -4)))
            .toList()
      ])),
    );
  }
}
