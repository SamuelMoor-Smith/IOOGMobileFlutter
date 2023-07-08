import 'package:namer_app/api/export/fields.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/models/project.dart';
import 'package:namer_app/utils/logging.dart';

import '../api/export/forms.dart';
import '../components/field_widgets/field_widget.dart';
import '../utils/form_manager.dart';
import 'form.dart';

class IOOGInstrument {
  String _name;
  String _label;
  IOOGProject _project;
  FormManager _FormManager = FormManager();

  List<IOOGSection>? _sections;
  List<IOOGForm>? _forms;
  int? _formIndex;

  IOOGInstrument(this._project, this._name, this._label) {
    setSections();
  }

  Future<void> setSections() async {
    await getFieldsForInstrumentFromREDCAP(_project, this).then((sections) {
      if (sections != null) {
        _sections = sections
            .where((IOOGSection section) => section.getFields().isNotEmpty)
            .toList();
      }
      printLog("initial form state set");
      _FormManager.setInitialFormState(this);
    });
  }

  Future<void> setForms() async {
    _forms ??= await getFormsForStudyIdAndInstrumentFromREDCAP(
        _project, this, _project.getActiveStudyId());
  }

  void setFormIndex(int? formIndex) {
    _formIndex = formIndex;
  }

  void updateAllFormFields(List<IOOGFieldWidget> fieldWidgets) {
    _FormManager.updateAllFormFields(fieldWidgets);
  }

  bool isSectioned() {
    return (_sections != null) && (_sections!.length > 1);
  }

  bool isDemographic() {
    return _label == "Basic Demography Form";
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

  void fillFieldsFromForm(int? index) {
    if (index == null) {
      printLog('No form index provided');
      return;
    }

    // Fill the form fields
    getAllFieldWidgets().forEach(
        (fieldWidget) => fieldWidget.fillField(_forms![index].getRecord()));
  }

  void clearAllFields() {
    for (IOOGFieldWidget fieldWidget in getAllFieldWidgets()) {
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
    return _FormManager;
  }
}
