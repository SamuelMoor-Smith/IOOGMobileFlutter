import 'package:flutter/material.dart';

import '../../models/choice.dart';
import '../field_widgets/multiple_choice/check_button.dart';
import '../field_widgets/multiple_choice/multiple_choice.dart';
import '../field_widgets/multiple_choice/radio_button.dart';

abstract class ImageButton extends StatefulWidget {

  final IOOGMultipleChoice group;
  final String name;
  late Choice choice;

  final double left;
  final double top;
  final double width;
  final double height;

  bool _isSelected = false;

  ImageButton({
    required this.group,
    required this.name,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  }) {
    choice = Choice.getChoiceByName(group.choices, name);
  }

  void onItemTapped(StateSetter setState) {
    setState(() {
      if (group is IOOGRadioGroup) {
        group.selectChoice(choice);
        group.updateForm();
      } else if (group is IOOGCheckGroup) {
        _isSelected = !_isSelected;
        _isSelected
            ? group.selectChoice(choice)
            : group.unselectChoice(choice);
        group.updateForm();
      }
    });
    group.updateFormState();
  }

  Border border() {
    return Border.all(
      color: group.selectedChoices.contains(choice) ? Colors.green : Colors.black,
      width: 2.0,
    );
  }
}