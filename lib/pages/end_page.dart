import 'package:flutter/material.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/pages/selection/select_instrument.dart';
import 'package:namer_app/pages/selection/study_id.dart';
import 'package:namer_app/utils/navigation.dart';

import '../api/import/import.dart';

class EndPage extends StatelessWidget {
  final IOOGProject project;
  const EndPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Code for New Entry (Same Patient)
                nextPage(context, SelectInstrumentsPage(project));
              },
              child: Text('New Entry (Same Patient)'),
            ),
            SizedBox(
                height:
                    20), // This provides some vertical spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Code for New Entry (Different Patient)
                nextPage(context, StudyIdPage(project));
              },
              child: Text('New Entry (Different Patient)'),
            ),
          ],
        ),
      ),
    );
  }
}
