import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/bottom_nav_bar.dart';
import 'package:namer_app/services/form_key_manager.dart';

import '../../components/app_bar.dart';
import '../../components/field_widgets/field_widget.dart';
import '../../models/instrument/instrument.dart';
import '../summary.dart';

class IOOGPage extends StatefulWidget {
  final String title;
  final List<Widget?> fields;
  final Instrument instrument;
  final PageController controller;
  final int pageLength;

  const IOOGPage({
    Key? key,
    required this.title,
    required this.fields,
    required this.instrument,
    required this.controller,
    required this.pageLength,
  }) : super(key: key);

  @override
  _IOOGPageState createState() => _IOOGPageState();

  FormKeyManager getFormKeyManager() {
    return instrument.getFormKeyManager();
  }
}

class _IOOGPageState extends State<IOOGPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 300), () {
        // Delay until all widgets have been rendered
        List<IOOGFieldWidget> fieldWidgets =
            widget.fields.whereType<IOOGFieldWidget>().toList();
        widget.getFormKeyManager().updateAllFormFields(fieldWidgets);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: widget.fields.whereType<Widget>().toList(),
      ),
      bottomNavigationBar: createBottomNavigationBar(
        context,
        SummaryPage(fields: widget.fields, instrument: widget.instrument),
        widget.getFormKeyManager(),
        widget.controller,
        widget.pageLength,
      ),
    );
  }
}
