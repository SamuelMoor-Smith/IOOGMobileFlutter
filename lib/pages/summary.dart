import 'package:flutter/material.dart';
import 'package:namer_app/components/check_button.dart';
import 'package:namer_app/components/comments_field.dart';
import 'package:namer_app/components/radio_button.dart';
import 'package:namer_app/components/text_field.dart';
import 'package:namer_app/pages/study_id.dart';
import 'package:namer_app/services/REDCapAPI/redcap_api.dart';

import '../components/bottom_nav_bar.dart';
import '../models/multiple_choice/choice.dart';

String getTitle(fieldWidget) {
  switch (fieldWidget.runtimeType) {
    case IOOGTextFieldWidget:
      return fieldWidget.ioogTextField.field.field_label;
    case IOOGCommentsFieldWidget:
      return fieldWidget.ioogTextField.field.field_label;
    case IOOGRadioGroup:
      return fieldWidget.ioogMultipleChoiceRadioButton.field.field_label;
    case IOOGCheckGroup:
      return fieldWidget.ioogMultipleChoiceCheckButton.field.field_label;
    default:
      return "";
  }
}

String getInput(fieldWidget) {
  switch (fieldWidget.runtimeType) {
    case IOOGTextFieldWidget:
      return fieldWidget.ioogTextField.enteredText?.toString() ?? '';
    case IOOGCommentsFieldWidget:
      return fieldWidget.ioogTextField.enteredText?.toString() ?? '';
    case IOOGRadioGroup:
      return fieldWidget.ioogMultipleChoiceRadioButton.selectedChoice?.name ?? ''; 
    case IOOGCheckGroup:
      Set<Choice> selectedChoices =  fieldWidget.ioogMultipleChoiceCheckButton.selectedChoices;
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
