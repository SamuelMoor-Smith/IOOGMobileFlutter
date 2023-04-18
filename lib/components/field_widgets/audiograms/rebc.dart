import 'package:flutter/material.dart';
import 'package:namer_app/components/image_fields/audiograms/audiogram.dart';

import 'audiogram_button.dart';

class REBCButton extends AudiogramButton {

  REBCButton({
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
  State<REBCButton> createState() => _REBCButtonState();
}

class _REBCButtonState extends State<REBCButton> {
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
          onTap: () {return;},
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
