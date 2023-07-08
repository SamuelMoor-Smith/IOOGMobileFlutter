import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../style/containers/border.dart';
import '../../../style/text/title_list_tile.dart';

class IOOGRadioGroup extends IOOGMultipleChoice {
  IOOGRadioGroup({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
  }) : super(
            key: key, choices: choices, field: field, formManager: formManager);

  @override
  State<IOOGRadioGroup> createState() => _IOOGRadioGroup();

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
}

class _IOOGRadioGroup extends State<IOOGRadioGroup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkBranchingLogic(setState, mounted);
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
        TitleListTile(labelText: widget.getLabelText()),
        ...widget
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
            .toList()
      ])),
    );
  }
}
