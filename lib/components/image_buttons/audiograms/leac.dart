import 'package:flutter/material.dart';
import 'package:namer_app/components/image_buttons/audiograms/audiogram_button_group.dart';

import 'audiogram_button.dart';

class LEACButton extends AudiogramButton {
  LEACButton({
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
  AudiogramButtonState<LEACButton> createState() => _LEACButtonState();
}

class _LEACButtonState extends AudiogramButtonState<LEACButton> {
  @override
  Widget buttonIcon() {
    return ColorFiltered(
      colorFilter: widget.group.audiogramValue.value == widget.value
          ? ColorFilter.mode(Colors.blue, BlendMode.srcIn)
          : ColorFilter.mode(Colors.black, BlendMode.srcIn),
      child: Image.asset(
        'assets/images/audiograms/leac.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
