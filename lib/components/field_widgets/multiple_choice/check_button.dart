import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/style/borders.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../main.dart';
import '../../../models/field/field.dart';
import '../../../models/choice.dart';
import '../../../models/instrument/instrument.dart';

class IOOGCheckGroup extends IOOGMultipleChoice {

  IOOGCheckGroup ({ 
    Key? key,
    required Field field,
    required Instrument instrument,
    required Set<Choice> choices,
  }) : super(
          key: key,
          choices: choices,
          field: field,
          instrument: instrument
        );

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
  fillField(Map<String, String> rawRecord) {
    var fieldName = getFieldName();
    for (String name in rawRecord.keys) {
      if (name.startsWith(fieldName) && rawRecord[name] == "1") {
        fillChoiceByNum(name.split("___")[1]);
      }
    }
  }

  @override 
  updateForm() {
    var fields = instrument.getFormKey().currentState!.fields;
    for (Choice choice in choices) {
      if (selectedChoices.contains(choice)) {
        fields["${getFieldName()}___${choice.number}"]?.didChange("1");
      } else {
        fields["${getFieldName()}___${choice.number}"]?.didChange("0");
      }
    }
    instrument.getFormKey().currentState!.save();
  }
}

class _IOOGCheckGroup extends State<IOOGCheckGroup> {

  @override
  void initState() {
    super.initState();
    widget.getFormStateNotifier().addListener(() => widget.checkBranchingLogic(setState));
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
              child: Column(
                children: [
                  ListTile(
                    title: Text(widget.getLabelText(), style: primaryTextStyle(),),
                    visualDensity: VisualDensity(vertical: -4)
                  ), ...widget.getChoices().map((choice) => 
                    FormBuilderField(
                      name: "${widget.getFieldName()}___${choice.number}",
                      validator: widget.validator(),
                      builder: (FormFieldState<dynamic> state) {
                        return CheckboxListTile(
                          title: Text(choice.name, style: primaryTextStyle(),),
                          value: widget.getSelectedChoices().contains(choice),
                          onChanged: (bool? value) {
                            setState(() {
                              if (value != null) {
                                value ? widget.selectChoice(choice) : widget.unselectChoice(choice);
                                widget.updateForm();
                              }
                            });
                            widget.updateFormState();
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: VisualDensity(vertical: -4)
                        );
                      })).toList()
                  ]
              )
            );}
      ),
    );
  }
}