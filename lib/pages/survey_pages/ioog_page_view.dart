import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import '../../models/instrument/instrument.dart';

class IOOGPageView extends StatefulWidget {
  final Instrument instrument;

  final PageController controller = PageController();

  IOOGPageView({
    Key? key,
    required this.instrument,
  }) : super(key: key);

  @override
  _IOOGPageViewState createState() => _IOOGPageViewState();

  GlobalKey<FormBuilderState> getFormKey() {
    return instrument.getFormKey();
  }

  List<Widget> getPages() {
    if (!instrument.isSectioned()) {
      return [
        IOOGPage(
          title: instrument.getLabel(),
          fields: instrument.getFields(null),
          instrument: instrument,
          controller: controller,
          pageLength: 1,
        )
      ];
    }

    List<IOOGPage> pages = [];
    for (String section in instrument.getSections()) {
      pages.add(IOOGPage(
        title: section,
        fields: instrument.getFields(section),
        instrument: instrument,
        controller: controller,
        pageLength: instrument.getSections().length,
      ));
    }
    return pages;
  }
}

class _IOOGPageViewState extends State<IOOGPageView> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: widget.getFormKey(),
        onChanged: () {},
        autovalidateMode: AutovalidateMode.disabled,
        initialValue: const {},
        child: PageView(
          controller: widget.controller,
          physics: NeverScrollableScrollPhysics(), // Disable swipe navigation
          children: widget.getPages(),
        ));
  }
}
