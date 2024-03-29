import 'package:flutter/material.dart';
import 'package:namer_app/components/loading.dart';
import 'package:namer_app/pages/selection/select_form.dart';
import 'package:namer_app/models/instrument.dart';
import 'package:namer_app/pages/selection/study_id.dart';
import 'package:namer_app/pages/survey_pages/ioog_page_view.dart';
import 'package:namer_app/utils/navigation.dart';
import 'package:provider/provider.dart';

import '../../components/app_bar.dart';
import '../../models/project.dart';

class SelectInstrumentsPage extends StatefulWidget {
  IOOGProject project;
  SelectInstrumentsPage(this.project);

  @override
  _SelectInstrumentsPageState createState() => _SelectInstrumentsPageState();
}

class _SelectInstrumentsPageState extends State<SelectInstrumentsPage> {
  bool _isLoading = false;
  List<IOOGInstrument> instruments = [];

  @override
  void initState() {
    super.initState();
    loadInstruments();
  }

  Future<void> loadInstruments() async {
    setState(() {
      _isLoading = true;
    });
    instruments = widget.project.getFillableInstruments();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.project.getActiveStudyId(),
        onBackButtonPressed: () =>
            nextPage(context, StudyIdPage(widget.project)),
      ),
      body: ChangeNotifierProvider.value(
        value: widget.project,
        child: Consumer<IOOGProject>(builder: (context, instrument, child) {
          if (widget.project.isLoading()) {
            return Loading();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List<Widget>.generate(instruments.length, (int index) {
                IOOGInstrument instrument = instruments[index];
                double intensity = (index / instruments.length);
                Color buttonColor = Color.lerp(
                    Colors.blue.shade300, Colors.blue.shade800, intensity)!;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (instrument.isDemographic()) {
                          instrument.resetFieldsAndFormIndex(null);
                          nextPage(
                              context, IOOGPageView(instrument: instrument));
                        } else {
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
            );
          }
        }),
      ),
    );
  }
}
