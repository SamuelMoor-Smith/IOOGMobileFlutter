import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/models/section.dart';
import 'package:nb_utils/nb_utils.dart';

import '../components/field_widgets/field_widget.dart';
import '../services/REDCapAPI/services/fields_service.dart';
import '../services/form_key_manager.dart';
import 'form.dart';

class IOOGInstrument {
  String _name;
  String _label;

  FormKeyManager _formKeyManager = FormKeyManager();

  List<IOOGForm> _forms = [];
  int? _recordIndex;

  List<IOOGSection> _sections = [];
  // Map<String, List<IOOGFieldWidget>> _fields = {"base": []};

  IOOGInstrument(this._name, this._label);

  // Getters for all variables
  String getName() {
    return _name;
  }

  String getLabel() {
    return _label;
  }

  int? getRecordIndex() {
    return _recordIndex;
  }

  void setRecordIndex(int recordIndex) {
    _recordIndex = recordIndex;
  }

  // Caller needs access to form key
  GlobalKey<FormBuilderState> getFormKey() {
    return _formKeyManager.getFormKey();
  }

  FormKeyManager getFormKeyManager() {
    return _formKeyManager;
  }

  void updateAllFormFields(List<IOOGFieldWidget> fieldWidgets) {
    _formKeyManager.updateAllFormFields(fieldWidgets);
  }

  bool isSectioned() {
    return _sections.isNotEmpty;
  }

  Future<void> fetchFieldsForInstrument() async {
    // If the sections are empty, the instrument has not been initialized
    if (_sections.isEmpty) {
      await fetchFields(this);
    }
  }

  List<IOOGSection> getSections() {
    return _sections;
  }

  List<IOOGFieldWidget> getAllFieldWidgets() {
    List<IOOGFieldWidget> allFieldWidgets = [];
    _sections.forEach((section) {
      allFieldWidgets.addAll(section.getFields());
    });
    return allFieldWidgets;
  }

  void addForm(date, side, record) {
    _forms.add(IOOGForm(date, side, record));
  }

  void clearAllFields() {
    for (IOOGFieldWidget fieldWidget in getAllFieldWidgets()) {
      fieldWidget.clearField();
      fieldWidget.updateForm();
    }
  }

  Future<void> fetchForms() async {
    if (_forms.isEmpty) {
      await fillForms(this);
    }
  }

  List<IOOGForm> getForms() {
    return _forms;
  }

  void addSection(IOOGSection section) {
    _sections.add(section);
  }

  // void addFieldWidget(IOOGFieldWidget fieldWidget, String? section) {
  //   if (section.isEmptyOrNull) {
  //     _fields['base']!.add(fieldWidget);
  //     return;
  //   }

  //   if (!_fields.containsKey(section)) {
  //     _fields[section!] = [fieldWidget];
  //     _sections.add(section);
  //   } else {
  //     _fields[section!]!.add(fieldWidget);
  //   }
  // }
}
