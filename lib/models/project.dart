import 'package:flutter/material.dart';
import 'package:namer_app/api/export/studyIds.dart';
import 'package:namer_app/utils/logging.dart';

import '../api/export/instruments.dart';
import 'instrument.dart';

class IOOGProject extends ChangeNotifier {
  String apiUrl;
  String token;

  List<String>? _studyIds;
  String? _activeStudyId;

  List<IOOGInstrument>? _instruments;
  bool _studyIdsGrabbed = false;
  bool _instrumentsGrabbed = false;

  IOOGProject(this.apiUrl, this.token);

  Future<void> setStudyIds() async {
    _studyIds ??= await getStudyIdsForProjectFromREDCAP(this);
    _studyIdsGrabbed = true;
    notifyListeners();
  }

  Future<void> setInstruments() async {
    _instruments ??= await getInstrumentsForProjectFromREDCAP(this);
    _instrumentsGrabbed = true;
    notifyListeners();
  }

  bool isLoadingStudyIds() {
    return !_studyIdsGrabbed;
  }

  bool isLoading() {
    return !_instrumentsGrabbed;
  }

  void setActiveStudyId(String studyId) {
    _activeStudyId = studyId;

    // Set records for each instrument
    for (IOOGInstrument instrument in _instruments!) {
      printLog(instrument.getLabel());
      instrument.setForms();
    }
  }

  String getActiveStudyId() {
    if (_activeStudyId == null) {
      throw ArgumentError('Active study ID not set');
    }
    return _activeStudyId!;
  }

  // Getters for all variables
  List<IOOGInstrument> getFillableInstruments() {
    if (_instruments == null) {
      throw Exception("Instruments have not been set yet");
    }
    return _instruments!
        .where((dynamic instrument) =>
            (instrument is IOOGInstrument) &&
            instrument.getLabel() != "Study ID" &&
            instrument.getLabel() != "Phenx Audiogram Hearing Test" &&
            instrument.getLabel() != "Post-op imaging")
        .toList();
  }

  List<String> getStudyIds() {
    if (_studyIds == null) {
      throw Exception("Study IDs have not been set yet");
    }
    return _studyIds!;
  }

  IOOGInstrument getInstrumentByLabel(String label) {
    IOOGInstrument? instrument;
    if (_instruments == null) {
      throw Exception("Instruments have not been set yet");
    }

    for (IOOGInstrument i in _instruments!) {
      if (i.getLabel() == label) {
        instrument = i;
      }
    }
    if (instrument == null) {
      throw ArgumentError('Instrument $label not found');
    }
    return instrument;
  }
}
