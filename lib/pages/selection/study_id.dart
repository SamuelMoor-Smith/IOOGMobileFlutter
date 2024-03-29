import 'package:flutter/material.dart';
import 'package:namer_app/components/loading.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:namer_app/utils/navigation.dart';

import '../../models/project.dart';
import '../login.dart';
import './select_instrument.dart';

class StudyIdPage extends StatelessWidget {
  final IOOGProject project;

  StudyIdPage(this.project);

  void logout(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      // Note: make sure setStudyIds() returns a Future<void>
      future: project.setStudyIds(),
      builder: (context, snapshot) {
        // If the Future is still running, show a loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        // If we run into an error, display it to the user
        if (snapshot.hasError) {
          return Loading();
        }

        // If the Future is complete and no errors occurred,
        // access the _studyIds safely since we know it has been set
        return Scaffold(
            appBar: AppBar(
              title: const Text('Select Study Id'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () => logout(context),
                ),
              ],
              leading: null,
              automaticallyImplyLeading: false,
            ),
            body: project.isLoadingStudyIds()
                ? Loading()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SearchableList<String>(
                      autoFocusOnSearch: false,
                      initialList: project.getStudyIds(),
                      builder: (String studyId) => ListTile(
                        title: Text(studyId),
                        onTap: () {
                          project.setActiveStudyId(studyId);
                          nextPage(
                              context,
                              SelectInstrumentsPage(
                                  project)); // assuming nextPage takes context as an argument.
                        },
                      ),
                      filter: (value) => project
                          .getStudyIds()
                          .where(
                            (element) => element.toLowerCase().contains(value),
                          )
                          .toList(),
                      inputDecoration: InputDecoration(
                        labelText: "Search Study Ids",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  String? newStudyId = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      TextEditingController textController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text("Create new Study Id"),
                        content: TextField(
                          controller: textController,
                          decoration:
                              InputDecoration(hintText: "Enter new study id"),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop(textController.text);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  if (newStudyId != null && newStudyId.isNotEmpty) {
                    // you will need a method in your project class to add a new study id
                    project.setActiveStudyId(newStudyId);
                    nextPage(context, SelectInstrumentsPage(project));
                  }
                },
              ),
            ));
      },
    );
  }

  //     ListView.builder(
  //       itemCount: project.getStudyIds().length,
  //       itemBuilder: (context, index) {
  //         final studyId = project.getStudyIds()[index];

  //         return ListTile(
  //           title: Text(studyId),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       tooltip: 'Search study ids',
  //       onPressed: () => showSearch(
  //         context: context,
  //         delegate: SearchPage(
  //           onQueryUpdate: print,
  //           items: project.getStudyIds() ?? [],
  //           searchLabel: 'Search Study Ids',
  //           suggestion: ListView.builder(
  //             itemCount: project.getStudyIds().length,
  //             itemBuilder: (context, index) {
  //               final studyId = project.getStudyIds()[index];

  //               return ListTile(
  //                 title: Text(studyId),
  //               );
  //             },
  //           ),
  //           failure: const Center(
  //             child: Text('No study ids found :('),
  //           ),
  //           filter: (studyId) => [studyId],
  //           sort: (a, b) => a.compareTo(b),
  //           builder: (studyId) => ListTile(title: Text(studyId)),
  //         ),
  //       ),
  //       child: const Icon(Icons.search),
  //     ),
  //   );
  // }
}

// class StudyIdPage extends StatelessWidget {
//   final IOOGProject project;

//   StudyIdPage(this.project);

//   @override
//   Widget build(BuildContext context) {
//     final studyIdController = TextEditingController();
//     final primaryColor =
//         Theme.of(context).primaryColor; // Get primary color from the theme

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Study ID"),
//         backgroundColor: primaryColor,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               final selectedStudyId = await showSearch(
//                 context: context,
//                 delegate: StudyIdSearch(project.getStudyIds()),
//               );

//               if (selectedStudyId != null && selectedStudyId.isNotEmpty) {
//                 project.setActiveStudyId(selectedStudyId);
//                 nextPage(context, SelectInstrumentsPage(project));
//               }
//             },
//           ),
//         ],
//       ),
//       // ... rest of your code
//     );
//   }
// }
