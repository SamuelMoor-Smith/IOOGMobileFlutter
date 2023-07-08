import 'package:namer_app/api/export/studyIds.dart';

import '../api/export/instruments.dart';
import 'instrument.dart';

class IOOGProject {
  String apiUrl;
  String token;

  Set<String>? _studyIds;
  String? _activeStudyId;

  List<IOOGInstrument>? _instruments;

  IOOGProject(this.apiUrl, this.token);

  Future<void> setStudyIds() async {
    _studyIds ??= await getStudyIdsForProjectFromREDCAP(this);
  }

  Future<void> setInstruments() async {
    _instruments ??= await getInstrumentsForProjectFromREDCAP(this);
  }

  void setActiveStudyId(String studyId) {
    _activeStudyId = studyId;

    // Set records for each instrument
    for (IOOGInstrument instrument in _instruments!) {
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
            instrument.getLabel() != "Phenx Audiogram Hearing Test")
        .toList();
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
