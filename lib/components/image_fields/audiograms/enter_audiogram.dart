import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/title_list_tile.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../../models/project.dart';
import '../../../pages/survey_pages/ioog_page_view.dart';
import '../../../style/text/text_styles.dart';
import '../../../utils/navigation.dart';

// ignore: must_be_immutable
class EnterAudiogram extends IOOGFieldWidget {
  IOOGProject project;
  String type;

  EnterAudiogram(
      {required super.field,
      required super.formManager,
      required this.project,
      required this.type});

  @override
  void clearField() {
    return;
  }

  @override
  void fillField(rawRecord) {
    return;
  }

  @override
  bool isFilled() {
    return true;
  }

  @override
  void updateForm() {
    return;
  }

  @override
  IOOGFieldWidgetState<EnterAudiogram> createState() => _EnterAudiogramState();
}

class _EnterAudiogramState extends IOOGFieldWidgetState<EnterAudiogram> {
  @override
  Widget build(BuildContext context) {
    return FieldContainer(
        child: Column(
      children: [
        TitleListTile(labelText: 'Enter new audiogram here:'),
        ElevatedButton(
          onPressed: () async {
            await fillAudiogramByForm(
              audiogram: widget.project
                  .getInstrumentByLabel("Phenx Audiogram Hearing Test"),
              formManager: widget.formManager,
              type: widget.type,
            );
            nextPage(
                context,
                IOOGPageView(
                    instrument: widget.project
                        .getInstrumentByLabel("Phenx Audiogram Hearing Test")));
            // nextPage(
            //     context,
            //     IOOGPageView(
            //         instrument: widget.project
            //             .getInstrumentByLabel("Phenx Audiogram Hearing Test")));
            // nextPage(
            //   context, IOOGPageView(instrument: instrument));
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
                'Note: last pre-op audiogram was 2023-04-23.',
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
