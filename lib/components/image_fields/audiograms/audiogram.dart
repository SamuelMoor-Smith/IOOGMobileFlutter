// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:namer_app/components/image_buttons/audiograms/audiogram_button.dart';
import 'package:namer_app/components/image_buttons/audiograms/audiogram_button_group.dart';
import 'package:namer_app/components/image_buttons/audiograms/leac.dart';
import 'package:namer_app/components/image_buttons/audiograms/lebc.dart';
import 'package:namer_app/components/image_buttons/audiograms/reac.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/image_fields/audiograms/types.dart';

import '../../../models/field/field.dart';
import '../../../style/containers/field_container.dart';
import '../../../utils/form_manager.dart';
import '../../image_buttons/audiograms/rebc.dart';

class Audiogram extends IOOGFieldWidget {
  final double TOP_INIT = 132 - 3.1;
  final double LEFT_INIT = 44.8 * 1.32 - 3.1;
  final double TOP_DIFF = 44.7 / 2 * 1.32;
  final double LEFT_DIFF = 31 * 1.32;

  final AudiogramType type;
  List<AudiogramButton> buttons = [];
  List<AudiogramButtonGroup> groups = [];

  Audiogram({
    Key? key,
    required this.type,
    required Field field,
    required FormManager formManager,
  }) : super(key: key, field: field, formManager: formManager) {
    buttons = createButtons();
  }

  String getGroupString(int i) {
    return '${type.toString().split(".")[1]}${i + 1}';
  }

  List<AudiogramButton> createButtons() {
    for (int i = 0; i < 7; i++) {
      AudiogramButtonGroup group =
          AudiogramButtonGroup(getGroupString(i), formManager);
      groups.add(group);
      for (int j = 0; j < 21; j++) {
        String value = (j * 5).toString();
        double left = LEFT_INIT + i * LEFT_DIFF;
        double top = TOP_INIT + j * TOP_DIFF;

        AudiogramButton button = createButton(
            group: group,
            value: value,
            left: left,
            top: top,
            width: 20,
            height: 20);

        buttons.add(button);
      }
    }
    return buttons;
  }

  AudiogramButton createButton(
      {required AudiogramButtonGroup group,
      required String value,
      required double left,
      required double top,
      required double width,
      required double height}) {
    switch (type) {
      case AudiogramType.reac:
        return REACButton(
            group: group,
            value: value,
            left: left,
            top: top,
            width: width,
            height: height);
      case AudiogramType.rebc:
        return REBCButton(
            group: group,
            value: value,
            left: left,
            top: top,
            width: width,
            height: height);
      case AudiogramType.leac:
        return LEACButton(
            group: group,
            value: value,
            left: left,
            top: top,
            width: width,
            height: height);
      case AudiogramType.lebc:
        return LEBCButton(
            group: group,
            value: value,
            left: left,
            top: top,
            width: width,
            height: height);
      default:
        throw UnimplementedError();
    }
  }

  @override
  bool isFilled() {
    return true;
  }

  @override
  void updateForm() {
    // formManager.updateForm(field, '');
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

  List<AudiogramButtonGroup> getGroups() {
    return groups;
  }

  @override
  IOOGFieldWidgetState<Audiogram> createState() => _AudiogramState();
}

class _AudiogramState extends IOOGFieldWidgetState<Audiogram> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/audiogram.png'),
            width: 330,
            height: 759,
          ),
          ...widget.buttons,
        ],
      ),
    );
  }
}

// FieldContainer(
//         child: Padding(
//       padding: EdgeInsets.all(16.0),
//       child: 
