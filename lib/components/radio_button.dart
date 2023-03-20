import 'package:flutter/material.dart';
import 'package:namer_app/models/multiple_choice/choice.dart';
import 'package:namer_app/models/multiple_choice/radio_button.dart';
import 'package:namer_app/style/text_styles.dart';

import '../style/borders.dart';

class RadioGroup extends StatefulWidget {

  final REDCapRadioButton redCapRadioButton;

  const RadioGroup ({ Key? key, required this.redCapRadioButton }): super(key: key);

  @override
  State<RadioGroup> createState() => _RadioGroup();
}

class _RadioGroup extends State<RadioGroup> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: bordered,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.redCapRadioButton.field.field_label, style: primaryTextStyle(),),
            visualDensity: VisualDensity(vertical: -4)
          )
          ]..addAll(widget.redCapRadioButton.choices.map((choice) => 
                RadioListTile<Choice>(
                  title: Text(choice.name, style: primaryTextStyle(),),
                  value: choice,
                  groupValue: widget.redCapRadioButton.selectedChoice,
                  onChanged: (Choice? value) {
                    setState(() {
                      widget.redCapRadioButton.selectChoice(value);
                    });
                  },
                  visualDensity: VisualDensity(vertical: -4)
                )).toList()
    )));
  }
}