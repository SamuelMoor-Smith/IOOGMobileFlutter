import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/services/form_key_manager.dart';
import 'package:namer_app/style/borders.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../models/choice.dart';

class IOOGCheckGroup extends IOOGMultipleChoice {
  IOOGCheckGroup({
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
  updateForm() {
    for (Choice choice in choices) {
      var formFieldName = "${getFieldName()}___${choice.number}";
      if (selectedChoices.contains(choice)) {
        formKeyManager.updateForm(formFieldName, "1");
      } else {
        formKeyManager.updateForm(formFieldName, "0");
      }
    }
  }
}

class _IOOGCheckGroup extends State<IOOGCheckGroup> {
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
                      .map((choice) => FormBuilderField(
                          name: "${widget.getFieldName()}___${choice.number}",
                          validator: widget.validator(),
                          builder: (FormFieldState<dynamic> state) {
                            return CheckboxListTile(
                                title: Text(
                                  choice.name,
                                  style: primaryTextStyle(),
                                ),
                                value: widget
                                    .getSelectedChoices()
                                    .contains(choice),
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
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                visualDensity: VisualDensity(vertical: -4));
                          }))
                      .toList()
                ]));
          }),
    );
  }
}
