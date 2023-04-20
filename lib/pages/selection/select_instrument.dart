import 'package:flutter/material.dart';
import 'package:namer_app/pages/selection/select_form.dart';
import 'package:namer_app/pages/selection/study_id.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:namer_app/pages/survey_pages/ioog_page_view.dart';

import '../../main.dart';
import '../../services/REDCapAPI/services/fields_service.dart';
import '../../services/REDCapAPI/services/instrument_service.dart';

class SelectEntryPage extends StatefulWidget {
  @override
  _SelectEntryPageState createState() => _SelectEntryPageState();
}

class _SelectEntryPageState extends State<SelectEntryPage> {
  List<Instrument> instruments = [];

  @override
  void initState() {
    super.initState();
    loadInstruments();
  }

  Future<void> loadInstruments() async {
    List<Instrument> loadedInstruments = await getInstruments();
    setState(() {
      instruments = loadedInstruments;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await Future.delayed(Duration(milliseconds: 300));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => StudyIdPage()),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List<Widget>.generate(instruments.length, (int index) {
          Instrument instrument = instruments[index];
          double intensity = (index / instruments.length);
          Color buttonColor = Color.lerp(Colors.blue.shade300, Colors.blue.shade800, intensity)!;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: ElevatedButton(
                onPressed: () async {
                  await getFields(instrument);
                  if (instrument.label == "Basic Demography Form") {
                    await fillFields(instrument);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => IOOGPageView(instrument: instrument),
                    ));
                  } else {
                    await fillForms(instrument);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SelectForm(instrument: instrument),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  textStyle: TextStyle(fontSize: 25),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(instrument.label),
              ),
            ),
          );
        }),
      ),
    );
  }
}
