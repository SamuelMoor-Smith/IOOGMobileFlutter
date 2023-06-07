import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/services/form_key_manager.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../style/borders.dart';

class IOOGRadioGroup extends IOOGMultipleChoice {
  IOOGRadioGroup({
    Key? key,
    required Field field,
    required FormKeyManager formKeyManager,
    required Set<Choice> choices,
  }) : super(
            key: key,
            choices: choices,
            field: field,
            formKeyManager: formKeyManager);

  @override
  State<IOOGRadioGroup> createState() => _IOOGRadioGroup();

  @override
  validated() {
    return selectedChoices.isNotEmpty;
  }

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
  updateForm() {
    if (selectedChoices.isNotEmpty) {
      formKeyManager.updateForm(getFieldName(), selectedChoices.first.number);
    } else {
      formKeyManager.updateForm(getFieldName(), null);
    }
  }
}

class _IOOGRadioGroup extends State<IOOGRadioGroup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkBranchingLogic(setState);
    });
    widget.formKeyManager
        .getFormStateNotifier()
        .addListener(() => widget.checkBranchingLogic(setState));
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.shouldShow,
      child: FormBuilderField(
          name: widget.getFieldName(),
          validator: widget.validator(),
          builder: (FormFieldState<dynamic> state) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: bordered,
                child: Column(children: [
                  ListTile(
                      title: Text(
                        widget.getLabelText(),
                        style: primaryTextStyle(),
                      ),
                      visualDensity: VisualDensity(vertical: -4)),
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
                ]));
          }),
    );
  }
}
