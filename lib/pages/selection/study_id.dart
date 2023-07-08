import 'package:flutter/material.dart';
import 'package:namer_app/style/containers/form_container.dart';
import 'package:namer_app/utils/navigation.dart';

import '../../models/project.dart';
import './select_instrument.dart';

class StudyIdPage extends StatelessWidget {
  final IOOGProject project;

  StudyIdPage(this.project);

  @override
  Widget build(BuildContext context) {
    final studyIdController = TextEditingController();
    final primaryColor =
        Theme.of(context).primaryColor; // Get primary color from the theme

    return Scaffold(
      appBar: AppBar(
        title: Text("Study ID"),
        backgroundColor: primaryColor,
      ),
      body: FormContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: studyIdController,
              decoration: InputDecoration(
                hintText: 'Study ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(
                height:
                    20.0), // Add some space between the TextField and Button
            ElevatedButton(
              onPressed: () async {
                this.project.setActiveStudyId(studyIdController.text);
                nextPage(context, SelectInstrumentsPage(project));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    primaryColor, // Use the primary color from the theme
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Enter"),
            ),
          ],
        ),
      ),
    );
  }
}
