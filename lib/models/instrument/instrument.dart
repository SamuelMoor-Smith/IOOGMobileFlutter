import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../components/field_widgets/field_widget.dart';
import 'form.dart';

class Instrument {

  String name;
  String label;
  final formKey = GlobalKey<FormBuilderState>();
  final ValueNotifier<Map<String, String>> formStateNotifier = ValueNotifier<Map<String, String>>({});
  Map<String, List<IOOGFieldWidget>> fields = {"base": []};
  List<String> sections = [];
  List<IOOGForm> forms = [];

  Instrument(this.name, this.label);
  
  GlobalKey<FormBuilderState> getFormKey() {
    return formKey;
  }

  ValueNotifier<Map<String, String>> getFormStateNotifier() {
    return formStateNotifier;
  }

  bool isSectioned() {
    return sections.isNotEmpty;
  }

  List<IOOGFieldWidget> getFields(String? section) {
    if (section.isEmptyOrNull){
      return fields['base']!;
    }

    return fields[section]!;
  }

  List<String> getSections() {
    return sections;
  }

  List<IOOGFieldWidget> getAllFieldWidgets() {
    List<IOOGFieldWidget> allFieldWidgets = [];
    fields.forEach((key, value) {
      allFieldWidgets.addAll(value);
    });
    debugPrint(allFieldWidgets.toString());
    return allFieldWidgets;
  }

  void addForm(date, side, record) {
    forms.add(IOOGForm(date, side, record));
  }

  void clearForms() {
    forms = [];
  }

  List<IOOGForm> getForms() {
    return forms;
  }

  void addFieldWidget(IOOGFieldWidget fieldWidget, String? section) {
    if (section.isEmptyOrNull) {
      fields['base']!.add(fieldWidget);
      return;
    } 

    if (!fields.containsKey(section)) {
      fields[section!] = [fieldWidget];
      sections.add(section);
    } else {
      fields[section!]!.add(fieldWidget);
    }
  }
}