import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/multiple_choice/multiple_choice.dart';
import 'package:namer_app/components/field_widgets/text_widgets/text_widget.dart';
import 'package:namer_app/pages/selection/study_id.dart';

import '../components/bottom_nav_bar.dart';
import '../models/choice.dart';

String getTitle(fieldWidget) {
  return fieldWidget.getField().field_label ?? '';
}

String getInput(fieldWidget) {
  switch (fieldWidget.runtimeType) {
    case IOOGTextWidget:
      return fieldWidget.getEnteredText();
    case IOOGMultipleChoice:
      return fieldWidget.getSelectedChoices().map((choice) => choice.name).join(', ');
    default:
      return "";
  }
}

class SummaryPage extends StatelessWidget {

  final List<Widget?> fields;
  final Widget? nextPage;
  final Widget? lastPage;

  const SummaryPage({Key? key,
    required this.fields,
    this.nextPage,
    this.lastPage}) : 
    super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Summary Page"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: fields.length,
        itemBuilder: (BuildContext context, int index) {
          final field = fields[index];
          // final selectedChoices = field.multipleChoice?.selectedChoices;

          // Create the title with bold text
          final title = Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${getTitle(field)}: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );

          // Create the list tile with the title and choices
          return ListTile(
            title: title,
            subtitle: Text(getInput(field)),
          );
        },
      ),
      bottomNavigationBar: createBottomNavigationBar(context, SummaryPage(fields: fields, nextPage: StudyIdPage(), lastPage: this), StudyIdPage()),
    );
  }
}
