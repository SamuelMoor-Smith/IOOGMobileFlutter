import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/components/loading.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import '../../models/instrument.dart';
import '../../api/old/services/fields_service.dart';

class IOOGPageView extends StatefulWidget {
  final IOOGInstrument instrument;

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

  void setPages(List<IOOGPage> pages) {
    for (IOOGSection section in instrument.getSections()) {
      pages.add(IOOGPage(
        section: section,
        instrument: instrument,
        controller: controller,
        pageLength: instrument.getSections().length,
      ));
    }
  }
}

class _IOOGPageViewState extends State<IOOGPageView> {
  bool _isLoading = false;
  List<IOOGPage> pages = [];

  @override
  void initState() {
    super.initState();
    loadIOOGPageView();
  }

  Future<void> loadIOOGPageView() async {
    setState(() {
      _isLoading = true;
    });

    // fetch the fields if they aren't there already
    await widget.instrument.fetchFieldsForInstrument();
    widget.setPages(pages);

    if (widget.instrument.getRecordIndex() != null) {
      await fillFieldsFromRecord(
          widget.instrument,
          widget.instrument
              .getForms()[widget.instrument.getRecordIndex()!]
              .getRecord());
    } else {
      await fillFields(widget.instrument);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: widget.getFormKey(),
        onChanged: () {
          widget.instrument.getFormKeyManager().saveForm();
        },
        autovalidateMode: AutovalidateMode.disabled,
        child: _isLoading
            ? Loading()
            : PageView(
                controller: widget.controller,
                physics:
                    NeverScrollableScrollPhysics(), // Disable swipe navigation
                children: pages,
              ));
  }
}
