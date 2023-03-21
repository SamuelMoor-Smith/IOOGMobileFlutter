import 'package:flutter/material.dart';
import 'package:namer_app/components/check_button.dart';
import 'package:namer_app/components/comments_field.dart';
import 'package:namer_app/components/radio_button.dart';
import 'package:namer_app/components/text_field.dart';
import 'package:namer_app/models/multiple_choice/radio_button.dart';
import 'package:namer_app/models/text_field.dart';
import 'package:namer_app/pages/study_id.dart';
import 'package:namer_app/services/REDCapAPI/redcap_api.dart';

import '../components/bottom_nav_bar.dart';
import '../models/multiple_choice/check_group.dart';
import '../models/multiple_choice/choice.dart';

String getTitle(fieldWidget) {
  return fieldWidget.getField().field_label ?? '';
}

String getInput(fieldWidget) {
  var customField = fieldWidget.getCustomField();
  switch (customField.runtimeType) {
    case IOOGTextField:
      return customField.enteredText?.toString() ?? '';
    case IOOGMultipleChoiceRadioButton:
      return customField.selectedChoice?.name ?? ''; 
    case IOOGMultipleChoiceCheckButton:
      Set<Choice> selectedChoices = customField.selectedChoices;
      return selectedChoices.map((choice) => choice.name).join(', ');
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
