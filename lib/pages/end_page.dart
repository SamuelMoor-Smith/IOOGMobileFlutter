import 'package:flutter/material.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/pages/selection/select_instrument.dart';
import 'package:namer_app/pages/selection/study_id.dart';
import 'package:namer_app/style/end_button.dart';
import 'package:namer_app/utils/navigation.dart';

class EndPage extends StatelessWidget {
  final IOOGProject project;
  const EndPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Next Steps'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Display the success message similar to the logo's height
          Expanded(
            flex: 15,
            child: Center(
              child: Text(
                "Success.\nThank you!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2, // occupies 1 part of the total space
            child: EndButton(
              label: 'New Entry (Same Patient)',
              onPressed: () {
                nextPage(context, SelectInstrumentsPage(project));
              },
              backgroundColor: Colors.white, // Retaining white for this button
            ),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 2, // occupies 1 part of the total space
            child: EndButton(
              label: 'New Entry (Different Patient)',
              onPressed: () {
                nextPage(context, StudyIdPage(project));
              },
              backgroundColor: Colors.blue[700]!, // Darker shade of blue
              foregroundColor: Colors.white,
            ),
          ),
          Spacer(flex: 3), // This gives a space of 1 part
        ],
      ),
    );
  }
}
