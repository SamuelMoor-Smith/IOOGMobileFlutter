import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/field_widgets/field_widget.dart';
import '../../services/form_key_manager.dart';
import 'form.dart';

class Instrument {
  String _name;
  String _label;

  FormKeyManager _formKeyManager = FormKeyManager();

  List<IOOGForm> _forms = [];
  List<String> _sections = [];
  Map<String, List<IOOGFieldWidget>> _fields = {"base": []};

  Instrument(this._name, this._label);

  // Getters for all variables
  String getName() {
    return _name;
  }

  String getLabel() {
    return _label;
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

  List<IOOGFieldWidget> getFields(String? section) {
    if (section.isEmptyOrNull) {
      return _fields['base']!;
    }

    return _fields[section]!;
  }

  List<String> getSections() {
    return _sections;
  }

  List<IOOGFieldWidget> getAllFieldWidgets() {
    List<IOOGFieldWidget> allFieldWidgets = [];
    _fields.forEach((key, value) {
      allFieldWidgets.addAll(value);
    });
    debugPrint(allFieldWidgets.toString());
    return allFieldWidgets;
  }

  void addForm(date, side, record) {
    _forms.add(IOOGForm(date, side, record));
  }

  void clear() {
    clearForms();
    clearFields();
    _formKeyManager.regenerateFormKeyAndNotifier();
  }

  void clearForms() {
    _forms = [];
  }

  void clearFields() {
    _fields = {"base": []};
    _sections = [];
  }

  List<IOOGForm> getForms() {
    return _forms;
  }

  void addFieldWidget(IOOGFieldWidget fieldWidget, String? section) {
    if (section.isEmptyOrNull) {
      _fields['base']!.add(fieldWidget);
      return;
    }

    if (!_fields.containsKey(section)) {
      _fields[section!] = [fieldWidget];
      _sections.add(section);
    } else {
      _fields[section!]!.add(fieldWidget);
    }
  }
}
