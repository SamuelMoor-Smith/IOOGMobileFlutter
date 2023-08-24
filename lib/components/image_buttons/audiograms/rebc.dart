import 'package:flutter/material.dart';
import 'package:namer_app/components/image_buttons/audiograms/audiogram_button_group.dart';
import 'package:namer_app/utils/logging.dart';

import 'audiogram_button.dart';

class REBCButton extends AudiogramButton {
  REBCButton({
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
  AudiogramButtonState<REBCButton> createState() => _REBCButtonState();
}

class _REBCButtonState extends AudiogramButtonState<REBCButton> {
  @override
  Widget buttonIcon() {
    return ColorFiltered(
      colorFilter: widget.group.audiogramValue.value == widget.value
          ? ColorFilter.mode(Colors.black, BlendMode.srcIn)
          : ColorFilter.mode(Colors.grey, BlendMode.srcIn),
      child: Image.asset(
        'assets/images/audiograms/rebc.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
