import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';

import '../../../style/containers/field_container.dart';
import '../../../style/text/title_list_tile.dart';
import '../field_widget_group.dart';

class LeftRightGroup extends IOOGFieldWidgetGroup {
  IOOGFieldWidget left;
  IOOGFieldWidget right;

  LeftRightGroup({required this.left, required this.right})
      : super(fieldWidgets: [left, right]);

  @override
  _LeftRightGroupState createState() => _LeftRightGroupState();
}

class _LeftRightGroupState extends State<LeftRightGroup> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
        offstage: !widget.left.shouldShow && !widget.right.shouldShow,
        child: FieldContainer(
          child: Column(
            children: [
              TitleListTile(
                labelText:
                    widget.left.getLabelText().replaceAll(" left ear", ""),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70, // change this width according to your needs
                      child: Text('Right Ear:'),
                    ),
                    Expanded(child: widget.right),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 70, // change this width according to your needs
                      child: Text('Left Ear:'),
                    ),
                    Expanded(child: widget.left),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
