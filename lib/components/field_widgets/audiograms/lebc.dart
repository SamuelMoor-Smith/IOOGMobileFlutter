import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/audiograms/audiogram_button_group.dart';

import 'audiogram_button.dart';

class LEBCButton extends AudiogramButton {
  LEBCButton({
    Key? key,
    required AudiogramButtonGroup group,
    required String value,
    required double left,
    required double top,
    required double width,
    required double height,
  }) : super(
          key: key,
          group: group,
          value: value,
          left: left,
          top: top,
          width: width,
          height: height,
        );

  @override
  AudiogramButtonState<LEBCButton> createState() => _LEBCButtonState();
}

class _LEBCButtonState extends AudiogramButtonState<LEBCButton> {
  @override
  Widget buttonIcon() {
    return ColorFiltered(
      colorFilter: widget.group.audiogramValue.value == widget.value
          ? ColorFilter.mode(Colors.black, BlendMode.srcIn)
          : ColorFilter.mode(Colors.grey, BlendMode.srcIn),
      child: Image.asset(
        'assets/images/audiograms/lebc.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
