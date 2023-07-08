import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/title_list_tile.dart';

import '../../../models/project.dart';
import '../../../pages/survey_pages/ioog_page_view.dart';
import '../../../style/text/text_styles.dart';
import '../../../utils/navigation.dart';

// ignore: must_be_immutable
class EnterAudiogram extends IOOGFieldWidget {
  IOOGProject project;

  EnterAudiogram(
      {required super.field,
      required super.formKeyManager,
      required this.project});

  @override
  _EnterAudiogramState createState() => _EnterAudiogramState();

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
}

class _EnterAudiogramState extends State<EnterAudiogram> {
  @override
  Widget build(BuildContext context) {
    return FieldContainer(
        child: Column(
      children: [
        TitleListTile(labelText: 'Enter new audiogram here:'),
        ElevatedButton(
          onPressed: () {
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
          child: Text('Enter Audiogram'),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        Text(
          'Note: last pre-op audiogram was 2023-04-23.',
          style: secondaryTextStyle(),
        ),
      ],
    ));
  }
}
