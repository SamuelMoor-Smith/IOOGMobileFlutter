import 'package:flutter/material.dart';
import 'package:namer_app/models/multiple_choice/choice.dart';
import 'package:namer_app/models/multiple_choice/radio_button.dart';
import 'package:namer_app/style/text_styles.dart';

import '../models/field.dart';
import '../style/borders.dart';

class IOOGRadioGroup extends StatefulWidget {

  final IOOGMultipleChoiceRadioButton ioogMultipleChoiceRadioButton;

  const IOOGRadioGroup ({ Key? key, required this.ioogMultipleChoiceRadioButton }): super(key: key);

  @override
  State<IOOGRadioGroup> createState() => _IOOGRadioGroup();

  IOOGMultipleChoiceRadioButton getCustomField() {
    return ioogMultipleChoiceRadioButton;
  }

  Field getField() {
    return ioogMultipleChoiceRadioButton.field;
  }

  void setChoice(int choiceNum) {
    for (Choice choice in ioogMultipleChoiceRadioButton.choices) {
      if (choice.number == choiceNum) {
        ioogMultipleChoiceRadioButton.selectedChoice = choice;
      }
    }
  }
}

class _IOOGRadioGroup extends State<IOOGRadioGroup> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: bordered,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.ioogMultipleChoiceRadioButton.field.field_label, style: primaryTextStyle(),),
            visualDensity: VisualDensity(vertical: -4)
          )
          ]..addAll(widget.ioogMultipleChoiceRadioButton.choices.map((choice) => 
                RadioListTile<Choice>(
                  title: Text(choice.name, style: primaryTextStyle(),),
                  value: choice,
                  groupValue: widget.ioogMultipleChoiceRadioButton.selectedChoice,
                  onChanged: (Choice? value) {
                    setState(() {
                      widget.ioogMultipleChoiceRadioButton.selectChoice(value);
                    });
                  },
                  visualDensity: VisualDensity(vertical: -4)
                )).toList()
    )));
  }
}