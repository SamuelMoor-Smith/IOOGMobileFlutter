import 'package:flutter/material.dart';
import 'package:namer_app/pages/ioog_page.dart';
import 'package:namer_app/models/app_field/instrument.dart';

import '../services/REDCapAPI/services/fields_service.dart';

class SelectEntryPage extends StatelessWidget {

  final List<Instrument> entries;

  const SelectEntryPage({Key? key, 
    required this.entries}) : 
    super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Entry Page"),
      ),
      body: Column(
        children: entries.map((entry) => 
          TextButton(
            onPressed: () async {
              final fieldWidgets = await getFields(entry);
              final filledWidgets = await fillFields(entry, fieldWidgets!.whereType<Widget>().toList());
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => IOOGPage(title: entry.label, fields: filledWidgets!),
              ));
            },  
            child: Text(entry.label)
          )).toList()
      ),
    );
  }
}