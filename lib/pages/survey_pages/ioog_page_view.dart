import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/bottom_nav_bar.dart';
import 'package:namer_app/pages/study_id.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';

import '../../components/field_widgets/field_widget.dart';
import '../../main.dart';
import '../../models/instrument/instrument.dart';
import '../summary.dart';

class IOOGPageView extends StatefulWidget {
  final Instrument instrument;
  final Widget? nextPage;
  final Widget? lastPage;

  const IOOGPageView({
    Key? key,
    required this.instrument,
    this.nextPage,
    this.lastPage,
  }) : super(key: key);

  @override
  _IOOGPageViewState createState() => _IOOGPageViewState();


  List<Widget> getPages() {
    if (!instrument.isSectioned()) {
      return [IOOGPage(title: instrument.label, fields: instrument.getFields(null), instrument: instrument)];
    }

    List<IOOGPage> pages = [];
    for (String section in instrument.getSections()) {
      pages.add(IOOGPage(title: section, fields: instrument.getFields(section), instrument: instrument));
    }
    return pages;
  }
}

class _IOOGPageViewState extends State<IOOGPageView> {

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      children: widget.getPages()
    );
  }
}