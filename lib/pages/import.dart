import 'package:flutter/material.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/pages/end_page.dart';
import 'package:namer_app/style/end_button.dart';
import 'package:namer_app/utils/navigation.dart';

import '../api/import/import.dart';

class Import extends StatelessWidget {
  final IOOGInstrument instrument;
  const Import({Key? key, required this.instrument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Import'),
      ),
      backgroundColor: Colors.blue, // Set the background color to blue
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center align the content
        children: [
          // Logo occupying 40% of the screen's space
          Expanded(
            flex: 5, // occupies 4 parts of the total space
            child: Center(
              // Centers the child widget
              child: Image.asset('assets/IOOGicon.png', fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 2, // occupies 1 part of the total space
            child: CircleAvatar(
              // White circular background
              backgroundColor: Colors.white,
              child: Icon(
                Icons.arrow_upward,
                color: Colors.blue, // Color of the arrow
                size: 25.0, // You can adjust the size as needed
              ),
            ),
          ),
          Spacer(flex: 1), // This gives a space of 1 part
          // Import button
          Expanded(
            flex: 1, // occupies 1 part of the total space
            child: EndButton(
                label: 'Import',
                onPressed: () {
                  importToREDCAP(instrument.getProject(), instrument)
                      .then((value) => {
                            if (value)
                              {
                                nextPage(context,
                                    EndPage(project: instrument.getProject()))
                              }
                          });
                }),
          ),
          Spacer(flex: 1), // This gives a space of 1 part
        ],
      ),
    );
  }
}
