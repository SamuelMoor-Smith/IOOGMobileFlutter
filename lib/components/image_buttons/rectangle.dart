import 'package:flutter/material.dart';

import '../../models/choice.dart';
import '../field_widgets/multiple_choice/check_button.dart';
import '../field_widgets/multiple_choice/multiple_choice.dart';
import '../field_widgets/multiple_choice/radio_button.dart';

class Rectangle extends StatefulWidget {
  final IOOGMultipleChoice group;
  final String name;
  late Choice choice;

  final double left;
  final double top;
  final double width;
  final double height;

  Rectangle({
    required this.group,
    required this.name,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  }) {
    choice = Choice.getChoiceByName(group.choices, name);
  }

  @override
  _RectangleState createState() => _RectangleState();
}

class _RectangleState extends State<Rectangle> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (widget.group is IOOGRadioGroup) {
                widget.group.selectChoice(widget.choice);
                widget.group.updateForm();
              } else if (widget.group is IOOGCheckGroup) {
                _isSelected = !_isSelected;
                _isSelected
                    ? widget.group.selectChoice(widget.choice)
                    : widget.group.unselectChoice(widget.choice);
                widget.group.updateForm();
              }
            });
            widget.group.updateFormState();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: _isSelected ? Colors.green : Colors.black,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
