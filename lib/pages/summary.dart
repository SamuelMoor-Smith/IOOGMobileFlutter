import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/api/import/import.dart';
import 'package:namer_app/pages/import.dart';
import 'package:namer_app/utils/navigation.dart';

import '../components/app_bar.dart';
import '../models/instrument.dart';
import '../models/section.dart';

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
  final IOOGInstrument instrument;

  const SummaryPage({
    Key? key,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instrument Title
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(instrument.getLabel(),
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),

              // Sections and their fields
              FutureBuilder<List<IOOGSection>>(
                future: instrument.getSections(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // List of Sections
                    List<IOOGSection> sections = snapshot.data ?? [];

                    return Column(
                      children: sections.map((section) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Title
                            if (sections.length > 1) ...[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(section.getLabel(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],

                            // Fields for this section
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                              },
                              children: section
                                  .getFields()
                                  .where((field) => getInput(field).isNotEmpty)
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int idx = entry.key;
                                Widget? field = entry.value;

                                return TableRow(
                                    decoration: BoxDecoration(
                                      color: idx % 2 == 1
                                          ? Colors.transparent
                                          : Colors.blue[50]!,
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          getTitle(field),
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
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 80.0), // Adjust the bottom padding
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              nextPage(context, Import(instrument: instrument));
            },
            child: Text('Proceed to Import'),
          ),
        ),
      ),
    );
  }
}
