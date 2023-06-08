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
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: GestureDetector(
          onTap: () {
            widget.onItemTapped(setState);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.elliptical(widget.width / 2, widget.height / 2),
              ),
              border: widget.border(),
            ),
          ),
        ),
      ),
    );
  }
}
