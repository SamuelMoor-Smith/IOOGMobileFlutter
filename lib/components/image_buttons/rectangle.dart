import 'package:flutter/material.dart';
import '../field_widgets/multiple_choice/multiple_choice.dart';
import 'image_button.dart';

class Rectangle extends ImageButton {
  Rectangle({
    required IOOGMultipleChoice group,
    required String name,
    required double left,
    required double top,
    required double width,
    required double height,
  }) : super(
            group: group,
            name: name,
            left: left,
            top: top,
            width: width,
            height: height);

  @override
  State<Rectangle> createState() => _RectangleState();
}

class _RectangleState extends State<Rectangle> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.group.selectedChoicesNotifier,
      builder: (context, _, child) {
        return Positioned(
          left: widget.left,
          top: widget.top,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: GestureDetector(
              onTap: () {
                widget.onItemTapped();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.group.selectedChoices.contains(widget.choice)
                        ? Colors.green
                        : Colors.black,
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
