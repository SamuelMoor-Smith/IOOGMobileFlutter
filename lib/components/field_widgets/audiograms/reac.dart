import 'package:flutter/material.dart';

import 'audiogram_button.dart';

class REACButton extends AudiogramButton {

  REACButton({
    Key? key,
    required String field,
    required String value,
    required double left,
    required double top,
    required double width,
    required double height,
  }) : super( 
    key: key, 
    field: field,
    value: value,
    left: left,
    top: top,
    width: width,
    height: height,
  );

  @override
  State<REACButton> createState() => _REACButtonState();
}

class _REACButtonState extends State<REACButton> {
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
              _isSelected = !_isSelected;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.elliptical(widget.width / 2, widget.height / 2),
              ),
              border: Border.all(
                color: _isSelected ? Colors.red : Colors.black,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
