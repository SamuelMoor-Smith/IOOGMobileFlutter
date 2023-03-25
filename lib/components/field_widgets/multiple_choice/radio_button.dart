import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../style/borders.dart';

class IOOGRadioGroup extends IOOGMultipleChoice {

  IOOGRadioGroup ({ Key? key, required Field field, required Set<Choice> choices }): super(key: key, field: field, choices: choices);

  @override
  State<IOOGRadioGroup> createState() => _IOOGRadioGroup();


  @override
  selectChoice(Choice choice) {
    selectedChoices.removeAll(choices); // Only 1 choice can be selected
    selectedChoices.add(choice);
  }

  @override
  unselectChoice(Choice choice) {
    selectedChoices.remove(choice);
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
            title: Text(widget.getLabelText(), style: primaryTextStyle(),),
            visualDensity: VisualDensity(vertical: -4)
          ), ...widget.getChoices().map((choice) => 
                RadioListTile<Choice>(
                  title: Text(choice.name, style: primaryTextStyle(),),
                  value: choice,
                  groupValue: widget.getSelectedChoices().first, // Only ever 1 choice selected
                  onChanged: (Choice? value) {
                    setState(() {
                      widget.selectChoice(value!);
                    });
                  },
                  visualDensity: VisualDensity(vertical: -4)
                )).toList()
          ]));
  }
}