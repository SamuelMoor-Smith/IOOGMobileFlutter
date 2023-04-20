import 'package:flutter/material.dart';
import 'package:namer_app/models/instrument/form.dart';
import 'package:namer_app/pages/selection/select_instrument.dart';

import '../../models/instrument/instrument.dart';
import '../../services/REDCapAPI/services/fields_service.dart';
import '../survey_pages/ioog_page_view.dart';

class SelectForm extends StatefulWidget {
  final Instrument instrument;

  SelectForm({required this.instrument});

  List<IOOGForm> getForms() {
    return instrument.getForms();
  }

  @override
  _SelectFormState createState() => _SelectFormState();
}

class _SelectFormState extends State<SelectForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit or Create Form"),
        leading: IconButton(
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
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => IOOGPageView(instrument: widget.instrument),
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          textStyle: TextStyle(fontSize: 18),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text("Create New Form"),
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
                          itemCount: widget.getForms().length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(widget.getForms()[index].toString()),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                color: Theme.of(context).primaryColor,
                                onPressed: () async {
                                  await fillFieldsFromRecord(widget.instrument, widget.getForms()[index].getRecord());
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) => IOOGPageView(instrument: widget.instrument),
                                  ));
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
