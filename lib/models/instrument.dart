import 'package:flutter/material.dart';
import 'package:namer_app/api/export/fields.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/utils/create_widgets.dart';
import 'package:namer_app/utils/logging.dart';

import '../api/export/forms.dart';
import '../components/field_widgets/field_widget.dart';
import '../utils/form_manager.dart';
import 'form.dart';

class IOOGInstrument extends ChangeNotifier {
  String _name;
  String _label;
  IOOGProject _project;
  FormManager _formManager = FormManager();

  List<IOOGSection>? _sections;
  List<IOOGForm>? _forms;
  int? _formIndex;

  bool _sectionsGrabbed = false;
  bool _formsGrabbed = false;

  IOOGInstrument(this._project, this._name, this._label) {
    setSections();
  }

  Future<void> setSections() async {
    _sectionsGrabbed = false;
    await getFieldsForInstrumentFromREDCAP(_project, this).then((sections) {
      if (sections != null) {
        _sections = sections
            .where((IOOGSection section) => section.getFields().isNotEmpty)
            .toList();
      }
      printLog("initial form state set");
      _formManager.setInitialFormState(this);
      _sectionsGrabbed = true;
      notifyListeners();
    });
  }

  Future<void> setForms() async {
    _formsGrabbed = false;
    _forms = null;
    _forms ??= await getFormsForStudyIdAndInstrumentFromREDCAP(
        _project, this, _project.getActiveStudyId());
    _formsGrabbed = true;
    notifyListeners();
  }

  void setFormIndex(int? formIndex) {
    _formIndex = formIndex;
  }

  void updateAllFormFields(List<IOOGFieldWidget> fieldWidgets) {
    _formManager.updateAllFormFields(fieldWidgets);
  }

  bool isSectioned() {
    return (_sections != null) && (_sections!.length > 1);
  }

  bool isDemographic() {
    return _label == "Basic Demography Form";
  }

  Future<List<IOOGSection>> getSections() async {
    if (_sections == null) {
      printLog("Sections have not been set yet");
      await setSections();
    }
    return _sections!;
  }

  Future<List<IOOGFieldWidget>> getAllFieldWidgets() async {
    List<IOOGFieldWidget> allFieldWidgets = [];
    await getSections();
    for (var section in _sections!) {
      allFieldWidgets.addAll(section.getFields());
    }
    return allFieldWidgets;
  }

  void fillFieldsFromForm(int? index) async {
    if (index == null) {
      printLog('No form index provided');
      return;
    }

    List<IOOGFieldWidget> fieldWidgets = await getAllFieldWidgets();
    for (IOOGFieldWidget fieldWidget in fieldWidgets) {
      fieldWidget.fillField(_forms![index].getRecord());
    }
  }

  void clearAllFields() async {
    List<IOOGFieldWidget> fieldWidgets = await getAllFieldWidgets();
    for (IOOGFieldWidget fieldWidget in fieldWidgets) {
      fieldWidget.clearField();
      fieldWidget.updateForm();
    }
  }

  List<IOOGForm> getForms() {
    if (_forms == null) {
      throw Exception("Forms have not been set yet");
    }
    return _forms!;
  }

  int? getFormIndex() {
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

  FormManager getFormManager() {
    return _formManager;
  }

  String? isLoading() {
    if (!_sectionsGrabbed) {
      return 'Please wait for sections to be grabbed';
    }

    if (!_formsGrabbed) {
      return 'Please wait for forms to be grabbed';
    }

    return null;
  }
}