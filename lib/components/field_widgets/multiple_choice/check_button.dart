import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/style/borders.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../main.dart';
import '../../../models/field/field.dart';
import '../../../models/choice.dart';

class IOOGCheckGroup extends IOOGMultipleChoice {

  IOOGCheckGroup ({ Key? key, required Field field, required Set<Choice> choices }): super(key: key, field: field, choices: choices);

  @override
  State<IOOGCheckGroup> createState() => _IOOGCheckGroup();

  @override
  selectChoice(Choice choice) {
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
    var fields = formKey.currentState!.fields;
    for (Choice choice in choices) {
      if (selectedChoices.contains(choice)) {
        fields["${getFieldName()}___${choice.number}"]?.didChange("1");
      } else {
        fields["${getFieldName()}___${choice.number}"]?.didChange("0");
      }
    }
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
            FormBuilderField(
              name: "${widget.getFieldName()}___${choice.number}",
              builder: (FormFieldState<dynamic> state) {
                return CheckboxListTile(
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
                );
              })).toList()
          ]
      )
    );
  }
}