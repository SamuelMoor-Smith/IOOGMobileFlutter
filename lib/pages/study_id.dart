import 'package:flutter/material.dart';
import 'package:namer_app/components/page.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/services/REDCapAPI/redcap_api.dart';

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
              final instruments = await ApiService().getInstruments();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ImagePage(),
              ));
            },  
            child: Text("Enter")
          )
        ]
      ),
    );
  }
}