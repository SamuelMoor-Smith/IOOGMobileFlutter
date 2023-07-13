import 'package:flutter/material.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../style/containers/field_container.dart';
import '../../style/text/title_list_tile.dart';
import '../field_widgets/field_widget.dart';
import '../field_widgets/multiple_choice/radio_button.dart';
import '../image_buttons/oval.dart';
import '../image_buttons/rectangle.dart';
import 'package:namer_app/models/choice.dart';
import '../../../models/field/field.dart';

class Cholesteatoma extends IOOGRadioGroup {
  Cholesteatoma({
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
  IOOGRadioGroupState<Cholesteatoma> createState() => _CholesteatomaState();
}

class _CholesteatomaState extends IOOGRadioGroupState<Cholesteatoma> {
  @override
  List<Widget> buildFieldWidgets() {
    return [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Stack(
            children: [
              Image(
                image: AssetImage('assets/images/cholesteatoma.png'),
                width: 260,
                height: 173,
              ),
              Rectangle(
                  group: widget,
                  name: "Congenital",
                  left: 18,
                  top: 52,
                  width: 51,
                  height: 16),
              Rectangle(
                  group: widget,
                  name: "Unclassifiable",
                  left: 176,
                  top: 52,
                  width: 62,
                  height: 16),
              Oval(
                  group: widget,
                  name: "Pars tensa",
                  left: 10,
                  top: 111,
                  width: 47,
                  height: 20),
              Oval(
                  group: widget,
                  name: "Pars flaccida",
                  left: 85,
                  top: 111,
                  width: 45,
                  height: 20),
              Oval(
                  group: widget,
                  name: "Secondary to TM perforation",
                  left: 132,
                  top: 108,
                  width: 62,
                  height: 27),
              Oval(
                  group: widget,
                  name: "Following trauma or iatrogenic",
                  left: 195,
                  top: 109,
                  width: 65,
                  height: 25),
              Oval(
                  group: widget,
                  name: "Combination of pars flaccida and pars tensa",
                  left: 24,
                  top: 129,
                  width: 96,
                  height: 24),
            ],
          ),
        ),
      ),
    ];
  }
}
