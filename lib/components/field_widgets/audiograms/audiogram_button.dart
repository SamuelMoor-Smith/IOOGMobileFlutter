import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/audiograms/audiogram_button_group.dart';
import 'package:provider/provider.dart';

abstract class AudiogramButton extends StatefulWidget {
  final AudiogramButtonGroup group;
  final String value;

  final double left;
  final double top;
  final double width;
  final double height;

  AudiogramButton({
    Key? key,
    required this.group,
    required this.value,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  }) : super(
          key: key,
        );

  @override
  State<AudiogramButton> createState();
}

abstract class AudiogramButtonState<T extends AudiogramButton>
    extends State<AudiogramButton> {
  @override
  void initState() {
    super.initState();
    widget.group.audiogramValue.addListener(() => {
          if (mounted) {setState(() {})}
        });
  }

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
              widget.group.setValue(widget.value);
            });
          },
          child: buttonIcon(),
        ),
      ),
    );
  }

  Widget buttonIcon();
}
