import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/bottom_nav_bar.dart';
import 'package:namer_app/pages/study_id.dart';

import '../main.dart';
import 'summary.dart';

class IOOGPage extends StatelessWidget {

  final String title;
  final List<Widget?> fields;
  final Widget? nextPage;
  final Widget? lastPage;

  const IOOGPage({Key? key, 
    required this.title, 
    required this.fields,
    this.nextPage,
    this.lastPage}) : 
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FormBuilder(
        key: formKey, 
        onChanged: () {
          formKey.currentState!.save();
          debugPrint(formKey.currentState!.value.toString());
        },
        autovalidateMode: AutovalidateMode.disabled,
        initialValue: const {},
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: fields.whereType<Widget>().toList(), // Filter null from list until handling all
        ),
      ),
      bottomNavigationBar: createBottomNavigationBar(context, SummaryPage(fields: fields, nextPage: StudyIdPage(), lastPage: this), StudyIdPage()),
    );
  }
}