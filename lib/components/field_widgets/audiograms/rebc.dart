import 'package:flutter/material.dart';

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
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
          child: ColorFiltered(
            colorFilter: _isSelected
                ? ColorFilter.mode(Colors.black, BlendMode.srcIn)
                : ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            child: Image.asset(
              'assets/images/audiograms/rebc.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
