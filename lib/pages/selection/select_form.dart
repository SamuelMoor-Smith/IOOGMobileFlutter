import 'package:flutter/material.dart';
import 'package:namer_app/models/form.dart';
import 'package:namer_app/utils/logging.dart';
import 'package:namer_app/utils/navigation.dart';
import 'package:provider/provider.dart';

import '../../components/app_bar.dart';
import '../../components/loading.dart';
import '../../models/instrument.dart';
import '../survey_pages/ioog_page_view.dart';

class SelectForm extends StatefulWidget {
  final IOOGInstrument instrument;

  SelectForm({required this.instrument});

  List<IOOGForm> getForms() {
    if (instrument.isLoading() == null) {
      return instrument.getForms();
    } else {
      printError('forms are still loading');
      return [];
    }
  }

  @override
  _SelectFormState createState() => _SelectFormState();
}

class _SelectFormState extends State<SelectForm> {
  bool _isLoading = false;

  Card buttonCard(String text, onClick) {
    return Card(
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
              text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadSelectForm();
  }

  Future<void> loadSelectForm() async {
    setState(() {
      _isLoading = true;
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit or Create Form"),
      body: ChangeNotifierProvider.value(
        value: widget.instrument,
        child: Consumer<IOOGInstrument>(builder: (context, instrument, child) {
          if (instrument.isLoading() != null) {
            return Loading();
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  buttonCard("Create New Entry", () {
                    widget.instrument.resetFieldsAndFormIndex(null);
                    nextPage(
                        context, IOOGPageView(instrument: widget.instrument));
                  }),
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
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            // Search bar or filters can be placed here if needed
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.getForms().length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                        widget.getForms()[index].toString()),
                                    trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        widget.instrument
                                            .resetFieldsAndFormIndex(index);
                                        nextPage(
                                            context,
                                            IOOGPageView(
                                                instrument: widget.instrument));
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
                  if (widget.instrument.getLabel() == "Post-op data")
                    buttonCard("Add Post-op imaging", () {
                      nextPage(
                          context,
                          IOOGPageView(
                              instrument: widget.instrument
                                  .getProject()
                                  .getInstrumentByLabel("Post-op imaging")));
                    }),
                  if (widget.instrument.getLabel() == "Post-op data")
                    SizedBox(height: 16),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
