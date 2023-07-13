// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/audiograms/audiogram_button.dart';
import 'package:namer_app/components/field_widgets/audiograms/leac.dart';
import 'package:namer_app/components/field_widgets/audiograms/lebc.dart';
import 'package:namer_app/components/field_widgets/audiograms/reac.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/image_fields/audiograms/types.dart';

import '../../../models/field/field.dart';
import '../../../utils/form_manager.dart';
import '../../field_widgets/audiograms/rebc.dart';

class Audiogram extends IOOGFieldWidget {
  final double TOP_INIT = 100;
  final double LEFT_INIT = 44.8;
  final double TOP_DIFF = 44.7 / 2;
  final double LEFT_DIFF = 31;

  final AudiogramType type;
  List<AudiogramButton> buttons = [];

  Audiogram({
    Key? key,
    required this.type,
    required Field field,
    required FormManager formManager,
  }) : super(key: key, field: field, formManager: formManager) {
    buttons = createButtons();
  }

  @override
  State<Audiogram> createState() => _AudiogramState();

  List<AudiogramButton> createButtons() {
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 21; j++) {
        // Add group dependant on i
        String value = (i * 5).toString();
        double left = LEFT_INIT + i * LEFT_DIFF;
        double top = TOP_INIT + j * TOP_DIFF;
        AudiogramButton? button;
        switch (type) {
          case AudiogramType.reac:
            button = REACButton(
                field: '${type.toString()}$i',
                value: value,
                left: left,
                top: top,
                width: 10,
                height: 10);
            break;
          case AudiogramType.rebc:
            button = REBCButton(
                field: '${type.toString()}$i',
                value: value,
                left: left,
                top: top,
                width: 10,
                height: 10);
            break;
          case AudiogramType.leac:
            button = LEACButton(
                field: '${type.toString()}$i',
                value: value,
                left: left,
                top: top,
                width: 10,
                height: 10);
            break;
          case AudiogramType.lebc:
            button = LEBCButton(
                field: '${type.toString()}$i',
                value: value,
                left: left,
                top: top,
                width: 10,
                height: 10);
            break;
        }
        buttons.add(button);
      }
    }
    return buttons;
  }

  @override
  bool isFilled() {
    return true;
  }

  @override
  void updateForm() {
    return;
    // for (AudiogramButton button in buttons) {
    //   // button.updateForm();
    // }
  }

  @override
  void fillField(dynamic rawRecord) {
    return;
  }

  @override
  void clearField() {
    return;
  }
}

class _AudiogramState extends State<Audiogram> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/audiogram_small.png'),
              width: 250,
              height: 575,
            ),
            ...widget.buttons,
          ],
        ),
      ),
    );
  }
}
