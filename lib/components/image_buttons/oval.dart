import 'package:flutter/material.dart';
import '../field_widgets/multiple_choice/multiple_choice.dart';
import 'image_button.dart';

class Oval extends ImageButton {
  Oval({
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
  State<Oval> createState() => _OvalState();
}

class _OvalState extends State<Oval> {
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
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(widget.width / 2, widget.height / 2),
                    ),
                    border: Border.all(
                      color:
                          widget.group.selectedChoices.contains(widget.choice)
                              ? Colors.green
                              : Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
