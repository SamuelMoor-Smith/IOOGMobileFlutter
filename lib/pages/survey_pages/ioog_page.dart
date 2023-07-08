import 'package:flutter/material.dart';
import 'package:namer_app/components/bottom_nav_bar.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/navigation.dart';

import '../../components/app_bar.dart';
import '../../components/field_widgets/field_widget.dart';
import '../../models/instrument.dart';
import '../../style/containers/form_container.dart';
import '../summary.dart';

class IOOGPage extends StatefulWidget {
  final IOOGSection _section;
  final IOOGInstrument _instrument;
  final PageController _controller;
  final int _pageLength;

  const IOOGPage({
    Key? key,
    required IOOGSection section,
    required IOOGInstrument instrument,
    required PageController controller,
    required int pageLength,
  })  : _controller = controller,
        _pageLength = pageLength,
        _instrument = instrument,
        _section = section,
        super(key: key);

  @override
  _IOOGPageState createState() => _IOOGPageState();

  FormManager getFormManager() {
    return _instrument.getFormManager();
  }

  List<Widget> get fields {
    return _section.getFields();
  }
}

class _IOOGPageState extends State<IOOGPage> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   printLog(
    //       "The current state is ${widget.instrument.getFormManager().getFormKey().currentState!.fields}");
    // });
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
      appBar: CustomAppBar(title: widget._section.getLabel()),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: widget.fields.whereType<IOOGFieldWidget>().toList(),
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
        SummaryPage(fields: widget.fields, instrument: widget._instrument),
        widget.getFormManager(),
        widget._controller,
        widget._pageLength,
      ),
    );
  }
}
