import 'package:flutter/material.dart';
import 'package:namer_app/pages/selection/select_form.dart';
import 'package:namer_app/models/instrument/instrument.dart';
import 'package:namer_app/pages/survey_pages/ioog_page_view.dart';
import 'package:namer_app/services/REDCapAPI/api_constants.dart';
import 'package:namer_app/utils.dart';

import '../../components/app_bar.dart';
import '../../services/REDCapAPI/services/fields_service.dart';
import '../../services/REDCapAPI/services/instrument_service.dart';

class SelectInstrumentsPage extends StatefulWidget {
  @override
  _SelectInstrumentsPageState createState() => _SelectInstrumentsPageState();
}

class _SelectInstrumentsPageState extends State<SelectInstrumentsPage> {
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
      appBar: CustomAppBar(
        title: APIConstants.studyId!,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List<Widget>.generate(instruments.length, (int index) {
          Instrument instrument = instruments[index];
          double intensity = (index / instruments.length);
          Color buttonColor = Color.lerp(
              Colors.blue.shade300, Colors.blue.shade800, intensity)!;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: ElevatedButton(
                onPressed: () async {
                  instrument.clear();
                  await getFields(instrument);
                  if (instrument.getLabel() == "Basic Demography Form") {
                    await fillFields(instrument);
                    nextPage(context, IOOGPageView(instrument: instrument));
                  } else {
                    await fillForms(instrument);
                    nextPage(context, SelectForm(instrument: instrument));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  textStyle: TextStyle(fontSize: 25),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: Text(instrument.getLabel()),
              ),
            ),
          );
        }),
      ),
    );
  }
}
