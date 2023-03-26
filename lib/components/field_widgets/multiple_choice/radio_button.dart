import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../main.dart';
import '../../../models/field/field.dart';
import '../../../style/borders.dart';

class IOOGRadioGroup extends IOOGMultipleChoice {

  IOOGRadioGroup ({ 
    Key? key,
    required Field field,
    required Set<Choice> choices,
  }) : super(
          key: key,
          choices: choices,
          field: field,
        );

  @override
  State<IOOGRadioGroup> createState() => _IOOGRadioGroup();


  @override
  selectChoice(Choice choice) {
    selectedChoices.removeAll(choices); // Only 1 choice can be selected
    selectedChoices.add(choice);
    updateForm();
  }

  @override
  unselectChoice(Choice choice) {
    selectedChoices.remove(choice);
    updateForm();
  }

  @override 
  updateForm() {
    var field = formKey.currentState!.fields[getFieldName()];
    if (selectedChoices.isNotEmpty) {
      field?.didChange(selectedChoices.first.number);
    } else {
      field?.didChange(null);
    }
  }
}

class _IOOGRadioGroup extends State<IOOGRadioGroup> {

  @override
  Widget build(BuildContext context) {
    return 
      FormBuilderField(
        name: widget.getFieldName(),
        builder: (FormFieldState<dynamic> state) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: bordered,
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.getLabelText(), style: primaryTextStyle(),),
                  visualDensity: VisualDensity(vertical: -4)
                ), ...widget.getChoices().map((choice) => 
                      RadioListTile<Choice>(
                        title: Text(choice.name, style: primaryTextStyle(),),
                        value: choice,
                        groupValue: widget.getSelectedChoices().isEmpty ? null : widget.getSelectedChoices().first, // Only ever 1 choice selected
                        onChanged: (Choice? value) {
                          setState(() {
                            widget.selectChoice(value!);
                          });
                        },
                        visualDensity: VisualDensity(vertical: -4)
                      )).toList()
                ]));
              });
  }
}