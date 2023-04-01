import 'package:flutter/material.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/services/REDCapAPI/services/import_service.dart';

import 'select_entry.dart';

class ImagePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Image Page"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Stack(
                  children: [
                    Image(
                      image: AssetImage('/Users/samuelmoor-smith/Desktop/flutter_application_2/assets/images/cholesteatoma.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      height: 300,
                      color: Colors.blue[200],
                      child: Text("hey"),
                    ),
                  ]
                )
                )
              ]
            ),
          );
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Image(
          //     image: AssetImage('../../assets/images/mastoidectomy_w_mu.png'),
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Image(
          //     image: AssetImage('../../assets/images/ossicularchain_w_ou.png'),
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Image(
          //     image: AssetImage('../../assets/images/diagram.jpg'),
          //     fit: BoxFit.fitWidth,
          //   ),
          // )
  }
}