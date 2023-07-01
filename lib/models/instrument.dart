import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/api/export/fields.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/models/project.dart';
import 'package:nb_utils/nb_utils.dart';

import '../api/export/forms.dart';
import '../components/field_widgets/field_widget.dart';
import '../api/old/services/fields_service.dart';
import '../utils/form_key_manager.dart';
import 'form.dart';

class IOOGInstrument {
  String _name;
  String _label;
  IOOGProject _project;
  // List<dynamic>? _activeRecord;
  FormKeyManager _formKeyManager = FormKeyManager();

  List<IOOGSection>? _sections;
  List<IOOGForm>? _forms;
  int? _formIndex;
  // Map<String, List<IOOGFieldWidget>> _fields = {"base": []};

  IOOGInstrument(this._project, this._name, this._label) {
    setSections();
  }

  Future<void> setSections() async {
    _sections ??= await getFieldsForInstrumentFromREDCAP(_project, this);
  }

  Future<void> setForms() async {
    _forms ??= await getFormsForStudyIdAndInstrumentFromREDCAP(
        _project, this, _project.getActiveStudyId());
  }

  void setFormIndex(int formIndex) {
    _formIndex = formIndex;
  }

  void updateAllFormFields(List<IOOGFieldWidget> fieldWidgets) {
    _formKeyManager.updateAllFormFields(fieldWidgets);
  }

  bool isSectioned() {
    return (_sections != null) && (_sections!.length > 1);
  }

  List<IOOGSection> getSections() {
    if (_sections == null) {
      throw Exception("Sections have not been set yet");
    }
    return _sections!;
  }

  List<IOOGFieldWidget> getAllFieldWidgets() {
    List<IOOGFieldWidget> allFieldWidgets = [];
    if (_sections == null) {
      throw Exception("Sections have not been set yet");
    }
    for (var section in _sections!) {
      allFieldWidgets.addAll(section.getFields());
    }
    return allFieldWidgets;
  }

  // void addForm(date, side, record) {
  //   _forms.add(IOOGForm(date, side, record));
  // }

  void clearAllFields() {
    for (IOOGFieldWidget fieldWidget in getAllFieldWidgets()) {
      fieldWidget.clearField();
      fieldWidget.updateForm();
    }
  }

  // Future<void> fetchForms() async {
  //   if (_forms.isEmpty) {
  //     await fillForms(this);
  //   }
  // }

  List<IOOGForm> getForms() {
    if (_forms == null) {
      throw Exception("Forms have not been set yet");
    }
    return _forms!;
  }

  int? getRecordIndex() {
    return _formIndex;
  }

  String getName() {
    return _name;
  }

  String getLabel() {
    return _label;
  }

  IOOGProject getProject() {
    return _project;
  }

  GlobalKey<FormBuilderState> getFormKey() {
    return _formKeyManager.getFormKey();
  }

  FormKeyManager getFormKeyManager() {
    return _formKeyManager;
  }
}
