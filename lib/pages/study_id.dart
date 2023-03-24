import 'package:flutter/material.dart';
import 'package:namer_app/pages/ioog_page.dart';
import 'package:namer_app/models/app_field/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/services/REDCapAPI/import_service.dart';

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
      ),
      body: Column(
        children: [
          TextField(controller: studyIdController),
          TextButton(
            onPressed: () async {
              APIConstants.studyId = studyIdController.text;
              debugPrint(APIConstants.studyId);
              final instruments = await getInstruments();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SelectEntryPage(entries: instruments!),
              ));
            },  
            child: Text("Enter")
          )
        ]
      ),
    );
  }
}