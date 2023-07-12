import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/check_button.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/radio_button.dart';
import 'package:namer_app/components/image_fields/stages/stage.dart';
import 'package:namer_app/utils/form_manager.dart';

import 'package:namer_app/models/choice.dart';
import 'package:namer_app/utils/logging.dart';
import '../../../../models/field/field.dart';

const stage0 = {
  "fieldLabel": "Stage 0",
  "fieldNote": "No cholesteatoma present."
};

const stage1 = {
  "fieldLabel": "Stage 1",
  "fieldNote":
      "Cholesteatoma localized in the primary site*\n*The site of the cholesteatoma origin, i.e. the attic (A) for a pars flaccida cholesteatoma, the tympanic cavity (T) for pars tensa cholesteatoma, congenital cholesteatoma, and cholesteatoma secondary to a tensa perforation."
};

const stage2 = {
  "fieldLabel": "Stage 2",
  "fieldNote": "Cholesteatoma involving two or more sites."
};

class Stages extends IOOGRadioGroup {
  bool _isUpdating = false;

  Stages({
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
  State<Stages> createState() => _StageState();

  // Define function to check whether or not stage 2 cholesteatoma

  bool checkStam() {
    // Check if S1 or S2 is selected
    if (formManager.getFormStateNotifier().value['extent_cholesteatoma___1'] ==
            "1" ||
        formManager.getFormStateNotifier().value['extent_cholesteatoma___2'] ==
            "1") {
      return true;
    }

    // Check if there are 2 or more locations
    var count = 0;
    for (int i = 1; i < 7; i++) {
      if (formManager
              .getFormStateNotifier()
              .value['extent_cholesteatoma___$i'] ==
          "1") {
        count += 1;
      }
    }
    return count > 1;
  }

  @override
  updateForm() {
    _isUpdating = true;
    // Check if stage 0 (No cholesteatoma)
    if (formManager.getFormStateNotifier().value['cholesteatoma'] == "0") {
      formManager.updateForm('stage_of_cholesteatoma', "0");
      _isUpdating = false;
      return;
    }

    // Check if stage 4
    for (int i = 1; i < 7; i++) {
      if (formManager.getFormStateNotifier().value['stage4___$i'] == "1") {
        formManager.updateForm('stage_of_cholesteatoma', "4");
        _isUpdating = false;
        return;
      }
    }

    printLog("here");
    // Check if stage 3
    for (int i = 1; i < 7; i++) {
      if (formManager.getFormStateNotifier().value['stage3___$i'] == "1") {
        formManager.updateForm('stage_of_cholesteatoma', "3");
        _isUpdating = false;
        return;
      }
    }

    // Check if stage 2
    if (checkStam()) {
      formManager.updateForm('stage_of_cholesteatoma', "2");
      _isUpdating = false;
      return;
    }

    // Default: update to stage 1
    formManager.updateForm('stage_of_cholesteatoma', "1");
    _isUpdating = false;
  }
}

class _StageState extends State<Stages> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.formManager.getFormStateNotifier().addListener(() {
        if (!widget._isUpdating) {
          widget.updateForm();
        }
      });
    });
  }

  @override
  void dispose() {
    widget.formManager.getFormStateNotifier().removeListener(widget.updateForm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stage(
            // Stage 0
            field: Field.createFieldWithLabelAndNote(
                stage0['fieldLabel']!, stage0['fieldNote']!),
            formManager: widget.formManager,
            choices: {},
            isSelected: () =>
                widget.formManager
                    .getFormStateNotifier()
                    .value['stage_of_cholesteatoma'] ==
                "0"),
        Stage(
            // Stage 1
            field: Field.createFieldWithLabelAndNote(
                stage1['fieldLabel']!, stage1['fieldNote']!),
            formManager: widget.formManager,
            choices: {},
            isSelected: () =>
                widget.formManager
                    .getFormStateNotifier()
                    .value['stage_of_cholesteatoma'] ==
                "1"),
        Stage(
            // Stage 2
            field: Field.createFieldWithLabelAndNote(
                stage2['fieldLabel']!, stage2['fieldNote']!),
            formManager: widget.formManager,
            choices: {},
            isSelected: () =>
                widget.formManager
                    .getFormStateNotifier()
                    .value['stage_of_cholesteatoma'] ==
                "2"),
        // Stages 3 and 4 are added as separate field widgets
      ],
    );
  }
}
