import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';
import 'package:namer_app/style/containers/field_container.dart';
import 'package:namer_app/style/text/title_list_tile.dart';

import '../../../style/text/text_styles.dart';

// ignore: must_be_immutable
class EnterAudiogram extends IOOGFieldWidget {
  EnterAudiogram({required super.field, required super.formKeyManager});

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
            // Add your onPressed logic here
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
