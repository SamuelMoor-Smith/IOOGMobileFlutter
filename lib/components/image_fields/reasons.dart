import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/check_button.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/utils/form_manager.dart';

import 'package:namer_app/models/choice.dart';
import '../../../models/field/field.dart';
import '../field_widgets/field_widget.dart';

class Reasons extends IOOGCheckGroup {
  Reasons({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
  }) : super(
          key: key,
          choices: choices,
          field: field,
          formManager: formManager,
        );

  @override
  IOOGCheckGroupState<Reasons> createState() => _ReasonsState();
}

class _ReasonsState extends IOOGCheckGroupState<Reasons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.choices.map((choice) => _buildChoice(choice)).toList(),
    );
  }

  Widget _buildChoice(Choice choice) {
    bool isSelected = widget.selectedChoices.contains(choice);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            widget.unselectChoice(choice);
          } else {
            widget.selectChoice(choice);
          }
          widget.updateForm();
        });
      },
      child: FieldContainer(
        isSelected: isSelected,
        child: ListTile(
          title: Text(choice.name),
          // Modify the tile based on your requirements
        ),
      ),
    );
  }
}
