import 'package:flutter/material.dart';
import 'package:namer_app/components/image_buttons/audiograms/audiogram_button_group.dart';

import 'audiogram_button.dart';

class REACButton extends AudiogramButton {
  REACButton({
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
  AudiogramButtonState<REACButton> createState() => _REACButtonState();
}

class _REACButtonState extends AudiogramButtonState<REACButton> {
  @override
  Widget buttonIcon() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.elliptical(widget.width / 2, widget.height / 2),
        ),
        border: Border.all(
          color: widget.group.audiogramValue.value == widget.value
              ? Colors.red
              : Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}
