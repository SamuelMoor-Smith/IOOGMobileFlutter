import 'package:flutter/material.dart';
import 'package:namer_app/models/multiple_choice/check_group.dart';
import 'package:namer_app/style/borders.dart';
import 'package:namer_app/style/text_styles.dart';

class CheckGroup extends StatefulWidget {

  final REDCapCheckButton redCapCheckButton;

  const CheckGroup ({ Key? key, required this.redCapCheckButton }): super(key: key);

  @override
  State<CheckGroup> createState() => _CheckGroup();
}

class _CheckGroup extends State<CheckGroup> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: bordered,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.redCapCheckButton.field.field_label, style: primaryTextStyle(),),
            visualDensity: VisualDensity(vertical: -4)
          )
          ]..addAll(
          widget.redCapCheckButton.choices.map((choice) => 
                CheckboxListTile(
                  title: Text(choice.name, style: primaryTextStyle(),),
                  value: widget.redCapCheckButton.selectedChoices.contains(choice),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        value ? widget.redCapCheckButton.selectChoice(choice) : widget.redCapCheckButton.unselectChoice(choice);
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  visualDensity: VisualDensity(vertical: -4)
                )).toList())
      )
    );
  }
}