import 'package:flutter/material.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../models/choice.dart';
import '../../models/field/field.dart';
import '../field_widgets/multiple_choice/check_button.dart';
import '../image_buttons/oval.dart';

class Diagram extends IOOGCheckGroup {
  Diagram({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
  }) : super(
          key: key,
          choices: choices,
          field: field,
          formManager: formManager,
        );

  @override
  State<Diagram> createState() => _DiagramState();
}

class _DiagramState extends State<Diagram> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.shouldShow,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/diagram.jpg'),
              width: 260,
              height: 184,
            ),
            Oval(
                group: widget,
                name: "S1 Protympanum",
                left: 31,
                top: 61,
                width: 40,
                height: 40),
            Oval(
                group: widget,
                name: "A Epitympanum",
                left: 80,
                top: 34,
                width: 40,
                height: 40),
            Oval(
                group: widget,
                name: "Ma Antrum",
                left: 172,
                top: 46,
                width: 40,
                height: 40),
            Oval(
                group: widget,
                name: "T Meso/Hypo-Tympanum",
                left: 80,
                top: 112,
                width: 40,
                height: 40),
            Oval(
                group: widget,
                name: "S2 Sinus Tympani",
                left: 130,
                top: 92,
                width: 40,
                height: 40),
            Oval(
                group: widget,
                name: "Mc Mastoid cells",
                left: 178,
                top: 107,
                width: 40,
                height: 40),
          ],
        ),
      ),
    );
  }
}
