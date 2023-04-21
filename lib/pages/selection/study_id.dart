import 'package:flutter/material.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/utils.dart';

import '../../components/app_bar.dart';
import '../../services/REDCapAPI/services/instrument_service.dart';
import './select_instrument.dart';

class StudyIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studyIdController = TextEditingController();
    final primaryColor = Theme.of(context).primaryColor; // Get primary color from the theme

    return Scaffold(
      appBar: CustomAppBar(title: "Study ID"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
            SizedBox(height: 20.0), // Add some space between the TextField and Button
            ElevatedButton(
              onPressed: () async {
                APIConstants.studyId = studyIdController.text;
                nextPage(context, SelectInstrumentsPage());
              },
              child: Text("Enter"),
              style: ElevatedButton.styleFrom(
                primary: primaryColor, // Use the primary color from the theme
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
