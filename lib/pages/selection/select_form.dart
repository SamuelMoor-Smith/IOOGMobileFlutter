import 'package:flutter/material.dart';
import 'package:namer_app/pages/selection/select_entry.dart';

class SelectForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit or Create Form"),
        leading: IconButton( // Add this IconButton as a leading widget in AppBar
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => SelectEntryPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Entry",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to create form page
                        },
                        child: Text("Create New Form"),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          textStyle: TextStyle(fontSize: 18),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Flexible(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Old Form",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Search bar or filters can be placed here if needed
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10, // Replace this with the number of old forms
                          itemBuilder: (BuildContext context, int index) {
                            // Replace the following with the actual form data (label and date)
                            String formLabel = "R";
                            String formDate = "2023-04-17";
                            
                            return ListTile(
                              title: Text("$formLabel - $formDate"),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  // Navigate to edit form page
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
