import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/text_widgets/left_right_group.dart';
import 'package:namer_app/utils/logging.dart';

import '../components/field_widgets/field_widget.dart';

class IOOGSection {
  String _label;
  List<IOOGFieldWidget> _fields = [];

  IOOGSection(this._label);

  void addFieldWidget(IOOGFieldWidget fieldWidget) {
    _fields.add(fieldWidget);
  }

  List<IOOGFieldWidget> getFields() {
    return _fields;
  }

  List<Widget> getFormattedFieldWidgets() {
    List<Widget> formattedFieldWidgets = [];
    for (int i = 0; i < _fields.length; i++) {
      String fieldName = _fields[i].field.field_name;
      fieldName = fieldName.replaceAll("left", "");
      fieldName = fieldName.replaceAll("right", "");

      String nextFieldName = '';
      if (i + 1 < _fields.length) {
        nextFieldName = _fields[i + 1].field.field_name;
        nextFieldName = nextFieldName.replaceAll("left", "");
        nextFieldName = nextFieldName.replaceAll("right", "");
      }

      if (fieldName != '' && fieldName == nextFieldName) {
        if (_fields[i].field.field_name.contains('right')) {
          formattedFieldWidgets
              .add(LeftRightGroup(right: _fields[i], left: _fields[i + 1]));
        } else {
          formattedFieldWidgets
              .add(LeftRightGroup(right: _fields[i + 1], left: _fields[i]));
        }
        i++;
      } else {
        formattedFieldWidgets.add(_fields[i]);
      }
    }
    return formattedFieldWidgets;
  }

  String getLabel() {
    return _label;
  }
}
