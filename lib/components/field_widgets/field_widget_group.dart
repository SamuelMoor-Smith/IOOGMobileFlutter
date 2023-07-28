import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/field_widget.dart';

abstract class IOOGFieldWidgetGroup extends StatefulWidget {
  List<IOOGFieldWidget> fieldWidgets;

  IOOGFieldWidgetGroup({required this.fieldWidgets});
}
