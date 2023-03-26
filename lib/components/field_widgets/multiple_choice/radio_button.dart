import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/models/choice.dart';
import 'package:namer_app/style/text_styles.dart';

import '../../../models/field/field.dart';
import '../../../style/borders.dart';

class IOOGRadioGroup extends IOOGMultipleChoice {
  final Field field;
  final Set<Choice> choices;

  IOOGRadioGroup({
    Key? key,
    required this.field,
    required this.choices,
  }) : super(
          key: key,
          field: field,
          choices: choices,
          builder: (FormFieldState<String> state) {
            return _IOOGRadioGroupBody(
              state: state as _IOOGRadioGroupState,
              field: field,
              choices: choices,
            );
          },
        );

  @override
  _IOOGRadioGroupState createState() => _IOOGRadioGroupState();
}

class _IOOGRadioGroupState extends FormFieldState<String> {
  Choice? _selectedChoice;

  void updateSelectedChoice(Choice? choice) {
    _selectedChoice = choice;
    didChange(_selectedChoice?.value);
  }
}

class _IOOGRadioGroupBody extends StatelessWidget {
  final _IOOGRadioGroupState state;
  final Field field;
  final Set<Choice> choices;

  _IOOGRadioGroupBody({
    required this.state,
    required this.field,
    required this.choices,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: bordered,
      child: Column(
        children: [
          ListTile(
            title: Text(
              field.getLabelText(),
              style: primaryTextStyle(),
            ),
            visualDensity: VisualDensity(vertical: -4),
          ),
          ...choices.map(
            (choice) => RadioListTile<Choice>(
              title: Text(
                choice.name,
                style: primaryTextStyle(),
              ),
              value: choice,
              groupValue: state._selectedChoice,
              onChanged: (Choice? value) {
                state.updateSelectedChoice(value);
              },
              visualDensity: VisualDensity(vertical: -4),
            ),
          ),
        ],
      ),
    );
  }
}
