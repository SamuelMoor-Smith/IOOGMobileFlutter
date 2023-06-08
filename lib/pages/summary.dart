import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/pages/selection/study_id.dart';

import '../components/app_bar.dart';
import '../components/bottom_nav_bar.dart';
import '../models/instrument/instrument.dart';

String getTitle(fieldWidget) {
  return fieldWidget.getField().field_label ?? '';
}

String getInput(fieldWidget) {
  if (fieldWidget is IOOGTextWidget) {
    return fieldWidget.getEnteredText();
  } else if (fieldWidget is IOOGMultipleChoice) {
    return fieldWidget
        .getSelectedChoices()
        .map((choice) => choice.name)
        .join(', ');
  } else {
    return "";
  }
}

class SummaryPage extends StatelessWidget {
  final List<Widget?> fields;
  final Instrument instrument;

  const SummaryPage({
    Key? key,
    required this.fields,
    required this.instrument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Summary of Entries"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              // make the text bigger
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(instrument.getLabel(),
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: fields
                    .where((field) => getInput(field).isNotEmpty)
                    .toList()
                    .asMap()
                    .entries
                    .map((entry) {
                  int idx = entry.key;
                  Widget? field = entry.value;

                  return TableRow(
                      decoration: new BoxDecoration(
                        color: idx % 2 == 1
                            ? Colors.transparent
                            : Colors.blue[50]!,
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${getTitle(field)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(getInput(field)),
                        ),
                      ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ImportDataPage()),
              // );
            },
            child: Text('Proceed to Import'),
          ),
        ),
      ),
      // bottomNavigationBar: createBottomNavigationBar(
      //   context,
      //   SummaryPage(fields: fields, instrument: instrument)),
    );
  }
}
