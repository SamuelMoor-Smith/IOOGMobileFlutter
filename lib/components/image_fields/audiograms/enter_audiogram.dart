import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/title_list_tile.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/logging.dart';

import '../../../models/project.dart';
import '../../../pages/survey_pages/ioog_page_view.dart';
import '../../../style/text/text_styles.dart';
import '../../../utils/navigation.dart';
import '../../import_toast.dart';

// ignore: must_be_immutable
class EnterAudiogram extends IOOGFieldWidget {
  IOOGProject project;
  String type;
  String lastPreopAudiogramDate = "";

  EnterAudiogram(
      {required super.field,
      required super.formManager,
      required this.project,
      required this.type});

  @override
  void clearField() {
    lastPreopAudiogramDate = "";
    updateForm();
  }

  @override
  void fillField(rawRecord) {
    var fieldName = getFieldName();
    if (rawRecord.containsKey(fieldName) && rawRecord[fieldName]! != "") {
      lastPreopAudiogramDate = rawRecord[fieldName]!;
      updateForm();
    }
  }

  @override
  bool isFilled() {
    return true;
  }

  @override
  updateForm() {
    formManager.updateForm(getFieldName(), lastPreopAudiogramDate);
  }

  @override
  IOOGFieldWidgetState<EnterAudiogram> createState() => _EnterAudiogramState();
}

class _EnterAudiogramState extends IOOGFieldWidgetState<EnterAudiogram> {
  void updateChoice() {
    if (mounted) {
      setState(() {
        if (widget.formManager
            .getFormStateNotifier()
            .value
            .containsKey(widget.field.field_name)) {
          widget.lastPreopAudiogramDate = widget.formManager
              .getFormStateNotifier()
              .value[widget.field.field_name]!;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.formManager.getFormStateNotifier().addListener(() => updateChoice());
  }

  @override
  Widget build(BuildContext context) {
    return FieldContainer(
        child: Column(
      children: [
        TitleListTile(labelText: 'Enter new audiogram here:'),
        ElevatedButton(
          onPressed: () async {
            await fillAudiogramByForm(
              audiogram: widget.project.getAudiogramInstrument(),
              formManager: widget.formManager,
              type: widget.type,
            );
            // nextPage(
            //     context,
            //     IOOGPageView(
            //         instrument: widget.project
            //             .getInstrumentByLabel("Phenx Audiogram Hearing Test")));
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IOOGPageView(
                  instrument: widget.project.getAudiogramInstrument(),
                ),
              ),
            );

            if (result != null) {
              setState(() {
                widget.lastPreopAudiogramDate = result;
                createLastPreopDateToast();
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text('Enter Audiogram'),
        ),
        widget.type == "PREOP"
            ? Text(
                'Note: last pre-op audiogram was ${widget.lastPreopAudiogramDate != "" ? widget.lastPreopAudiogramDate : 'not filled'}.',
                style: secondaryTextStyle(),
              )
            : Container(),
      ],
    ));
  }
}

fillAudiogramByForm(
    {required IOOGInstrument audiogram,
    required FormManager formManager,
    required String type}) async {
  List<IOOGSection> sections = await audiogram.getSections();
  IOOGSection reac = sections[0];
  String dataKey = formManager
      .getFormStateNotifier()
      .value
      .keys
      .firstWhere((element) => element.startsWith("date"));

  (reac.getFields()[0] as IOOGTextWidget) // The date of audiogram field
      .setEnteredText(formManager.getFormStateNotifier().value[dataKey]!);

  if (type == "PREOP") {
    audiogram
        .getFormManager()
        .getFormStateNotifier()
        .value['redcap_event_name'] = "preop_status_arm_1";
  } else {
    audiogram
        .getFormManager()
        .getFormStateNotifier()
        .value['redcap_event_name'] = "postop_status_arm_1";
  }
}
