import 'package:flutter/material.dart';
import 'package:namer_app/models/multiple_choice/check_group.dart';
import 'package:namer_app/style/borders.dart';
import 'package:namer_app/style/text_styles.dart';

class IOOGCheckGroup extends StatefulWidget {

  final IOOGMultipleChoiceCheckButton ioogMultipleChoiceCheckButton;

  const IOOGCheckGroup ({ Key? key, required this.ioogMultipleChoiceCheckButton }): super(key: key);

  @override
  State<IOOGCheckGroup> createState() => _IOOGCheckGroup();
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
            title: Text(widget.ioogMultipleChoiceCheckButton.field.field_label, style: primaryTextStyle(),),
            visualDensity: VisualDensity(vertical: -4)
          )
          ]..addAll(
          widget.ioogMultipleChoiceCheckButton.choices.map((choice) => 
                CheckboxListTile(
                  title: Text(choice.name, style: primaryTextStyle(),),
                  value: widget.ioogMultipleChoiceCheckButton.selectedChoices.contains(choice),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null) {
                        value ? widget.ioogMultipleChoiceCheckButton.selectChoice(choice) : widget.ioogMultipleChoiceCheckButton.unselectChoice(choice);
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