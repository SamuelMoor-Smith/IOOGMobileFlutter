import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/bottom_nav_bar.dart';
import 'package:namer_app/pages/study_id.dart';

import '../components/field_widgets/field_widget.dart';
import '../main.dart';
import 'summary.dart';

class IOOGPage extends StatefulWidget {
  final String title;
  final List<Widget?> fields;
  final Widget? nextPage;
  final Widget? lastPage;

  const IOOGPage({
    Key? key,
    required this.title,
    required this.fields,
    this.nextPage,
    this.lastPage,
  }) : super(key: key);

  @override
  _IOOGPageState createState() => _IOOGPageState();
}

class _IOOGPageState extends State<IOOGPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (formKey.currentState != null) {
        for (IOOGFieldWidget fieldWidget in widget.fields.whereType<IOOGFieldWidget>().toList()) {
          fieldWidget.updateForm();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FormBuilder(
        key: formKey,
        onChanged: () {
          formKey.currentState!.save();
        },
        autovalidateMode: AutovalidateMode.disabled,
        initialValue: const {},
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: widget.fields.whereType<Widget>().toList(),
        ),
      ),
      bottomNavigationBar: createBottomNavigationBar(
        context,
        SummaryPage(fields: widget.fields, nextPage: StudyIdPage(), lastPage: widget),
        StudyIdPage(),
      ),
    );
  }
}
