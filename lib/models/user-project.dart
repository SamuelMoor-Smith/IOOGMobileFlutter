import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/field_widgets/field_widget.dart';
import '../../services/form_key_manager.dart';
import '../services/REDCapAPI/services/instrument_service.dart';
import 'instrument.dart';

class UserProject {
  List<IOOGInstrument> _instruments = [];

  UserProject() {
    fetchInstruments();
  }

  Future<void> fetchInstruments() async {
    if (_instruments.isEmpty) {
      _instruments = await getInstruments();
    }
  }

  // Getters for all variables
  Future<List<IOOGInstrument>> getInstrumentsForProject() async {
    await fetchInstruments();
    return _instruments;
  }
}
