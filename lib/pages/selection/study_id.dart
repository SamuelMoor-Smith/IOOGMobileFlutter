import 'package:flutter/material.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';

import '../../services/REDCapAPI/services/instrument_service.dart';
import './select_instrument.dart';

class StudyIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studyIdController = TextEditingController();
    final primaryColor = Theme.of(context).primaryColor; // Get primary color from the theme

    return Scaffold(
      appBar: AppBar(
        title: Text("Study ID"),
        backgroundColor: primaryColor, // Use the primary color from the theme
      ),
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SelectEntryPage(),
                ));
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
