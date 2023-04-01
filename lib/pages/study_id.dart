import 'package:flutter/material.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/services/REDCapAPI/services/import_service.dart';

import '../services/REDCapAPI/services/instrument_service.dart';
import 'image_page.dart';
import 'select_entry.dart';

class StudyIdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studyIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Study Id Page"),
        backgroundColor: Colors.deepPurple, // Change the AppBar color
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: studyIdController,
              decoration: InputDecoration(
                labelText: 'Enter Study ID',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20.0), // Add some space between the TextField and Button
            ElevatedButton(
              onPressed: () async {
                APIConstants.studyId = studyIdController.text;
                final instruments = await getInstruments();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SelectEntryPage(entries: instruments!),
                ));
              },
              child: Text("Enter"),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple, // Change the button color
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
