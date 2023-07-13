import 'package:flutter/material.dart';
import 'package:namer_app/utils/logging.dart';

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

  void onItemTapped() {
    bool _isSelected = group.selectedChoices.contains(choice);
    if (group is IOOGRadioGroup) {
      group.selectChoice(choice);
    } else if (group is IOOGCheckGroup) {
      _isSelected = !_isSelected;
      _isSelected ? group.selectChoice(choice) : group.unselectChoice(choice);
    }
    // Flip the bool to trigger listeners
    group.selectedChoicesNotifier.value = !group.selectedChoicesNotifier.value;
    group.updateForm();
  }

  // Border border() {
  //   return Border.all(
  //     color:
  //         group.selectedChoices.contains(choice) ? Colors.green : Colors.black,
  //     width: 2.0,
  //   );
  // }

  // void updateBorder(StateSetter setState) {
  //   setState(() {
  //     border = Border.all(
  //       color: group.selectedChoices.contains(choice)
  //           ? Colors.green
  //           : Colors.black,
  //       width: 2.0,
  //     );
  //   });
  // }
}
