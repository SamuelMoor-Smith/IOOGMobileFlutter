import 'package:flutter/material.dart';
import 'package:namer_app/components/bottom_nav_bar.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/utils/form_manager.dart';

import '../../components/field_widgets/field_widget.dart';
import '../../models/instrument.dart';
import '../summary.dart';

class IOOGPage extends StatefulWidget {
  final IOOGSection _section;
  final IOOGInstrument _instrument;
  final PageController _controller;
  final List<IOOGPage> _pages;

  const IOOGPage({
    Key? key,
    required IOOGSection section,
    required IOOGInstrument instrument,
    required PageController controller,
    required List<IOOGPage> pages,
  })  : _controller = controller,
        _pages = pages,
        _instrument = instrument,
        _section = section,
        super(key: key);

  @override
  _IOOGPageState createState() => _IOOGPageState();

  FormManager getFormManager() {
    return _instrument.getFormManager();
  }

  List<Widget> get fields {
    return _section.getFormattedFieldWidgets();
  }

  bool shouldShowPage() {
    return _section.getFields().any((field) {
      return field.checkBranchingLogicForPageLoad();
    });
  }
}

class _IOOGPageState extends State<IOOGPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      Future.delayed(Duration(milliseconds: 500), () {
        // Delay until all widgets have been rendered
        List<IOOGFieldWidget> fieldWidgets =
            widget.fields.whereType<IOOGFieldWidget>().toList();
        widget.getFormManager().updateAllFormFields(fieldWidgets);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._section.getLabel()),
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // This is the padding
          child: Column(
            children: widget.fields.whereType<Widget>().toList(),
          ),
        ),
      ),
      // body: FormContainer(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: widget.fields.whereType<IOOGFieldWidget>().toList(),
      //       ),
      //     ),
      //   )
      // ),
      bottomNavigationBar: createBottomNavigationBar(
        context,
        widget._section,
        widget._instrument,
        SummaryPage(instrument: widget._instrument),
        widget.getFormManager(),
        widget._controller,
        widget._pages,
      ),
    );
  }
}
