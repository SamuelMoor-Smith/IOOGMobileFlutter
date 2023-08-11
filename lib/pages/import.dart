import 'package:flutter/material.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/pages/end_page.dart';
import 'package:namer_app/utils/navigation.dart';

import '../api/import/import.dart';

class Import extends StatelessWidget {
  final IOOGInstrument instrument;
  const Import({Key? key, required this.instrument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            importToREDCAP(instrument.getProject(), instrument);
            nextPage(context, EndPage(project: instrument.getProject()));
          },
          child: Text('Import'),
        ),
      ),
    );
  }
}
