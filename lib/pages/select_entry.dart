import 'package:flutter/material.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:namer_app/pages/survey_pages/ioog_page_view.dart';

import '../main.dart';
import '../services/REDCapAPI/services/fields_service.dart';

class SelectEntryPage extends StatelessWidget {
  final List<Instrument> entries;

  const SelectEntryPage({
    Key? key,
    required this.entries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Entry Page"),
        backgroundColor: Colors.deepPurple, // Change the AppBar color
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            Instrument entry = entries[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await getFields(entry);
                  await fillFields(entry);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => IOOGPageView(instrument: entry),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, // Change the button color
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: Text(entry.label),
              ),
            );
          },
        ),
      ),
    );
  }
  
  // createFieldValues(List<Widget?>? filledWidgets) {
  //   Map<String, String> fieldValues = {};

  //   for (final widget in filledWidgets!.whereType<Widget>().toList()) {
  //     var fieldWidget;
  //     fieldValues[fieldWidget.getField().field_label] = fieldWidget.fieldValue;
  //   }
  // }
}
