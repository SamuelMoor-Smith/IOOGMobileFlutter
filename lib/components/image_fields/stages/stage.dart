import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/check_button.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/logging.dart';

import '../../../style/containers/field_container.dart';
import '../../../style/text/text_styles.dart';
import '../../../style/text/title_list_tile.dart';
import 'package:namer_app/models/choice.dart';
import '../../../../models/field/field.dart';

class Stage extends IOOGCheckGroup {
  final bool Function() isSelected;

  Stage({
    Key? key,
    required Field field,
    required FormManager formManager,
    required Set<Choice> choices,
    required this.isSelected,
  }) : super(
          key: key,
          choices: choices,
          field: field,
          formManager: formManager,
        );

  @override
  IOOGCheckGroupState<Stage> createState() => _StageState();
}

class _StageState extends IOOGCheckGroupState<Stage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.formManager.getFormStateNotifier(),
      builder:
          (BuildContext context, Map<String, dynamic> value, Widget? child) {
        printLog(widget.formManager.getFormStateNotifier().value.toString());
        return FieldContainer(
          isSelected: (widget as Stage).isSelected(),
          child: Column(children: [
            TitleListTile(
                labelText: widget.getLabelText(),
                fieldNote: widget.field.field_note),
            ...widget
                .getChoices()
                .map((choice) => CheckboxListTile(
                    title: Text(
                      choice.name,
                      style: primaryTextStyle(),
                    ),
                    value: widget.getSelectedChoices().contains(choice),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          value
                              ? widget.selectChoice(choice)
                              : widget.unselectChoice(choice);
                          widget.updateForm();
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    visualDensity: VisualDensity(vertical: -4)))
                .toList()
          ]),
        );
      },
    );
  }
}
