import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/style/borders.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../models/choice.dart';

class IOOGCheckGroup extends IOOGMultipleChoice {

  IOOGCheckGroup ({ Key? key, required Field field, required Set<Choice> choices }): super(key: key, field: field, choices: choices);

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
}

class _IOOGCheckGroup extends State<IOOGCheckGroup> {

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
                CheckboxListTile(
                  title: Text(choice.name, style: primaryTextStyle(),),
                  value: widget.getSelectedChoices().contains(choice),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        value ? widget.selectChoice(choice) : widget.unselectChoice(choice);
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity(vertical: -4)
                )).toList()
          ]
      )
    );
  }
}