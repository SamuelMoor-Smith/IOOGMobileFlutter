import 'package:flutter/material.dart';

import 'audiogram_button.dart';

class LEACButton extends AudiogramButton {

  LEACButton({
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
  State<LEACButton> createState() => _LEACButtonState();
}

class _LEACButtonState extends State<LEACButton> {
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
          child: ColorFiltered(
            colorFilter: _isSelected
                ? ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                : ColorFilter.mode(Colors.black, BlendMode.srcIn),
            child: Image.asset(
              '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/audiograms/leac.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
