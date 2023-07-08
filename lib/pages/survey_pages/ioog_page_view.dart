import 'package:flutter/material.dart';
import 'package:namer_app/components/loading.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import '../../models/instrument.dart';
import '../../utils/logging.dart';

class IOOGPageView extends StatefulWidget {
  final IOOGInstrument instrument;

  final PageController controller = PageController();

  IOOGPageView({
    Key? key,
    required this.instrument,
  }) : super(key: key);

  @override
  _IOOGPageViewState createState() => _IOOGPageViewState();

  // GlobalKey<FormBuilderState> getFormKey() {
  //   return instrument.getFormKey();
  // }

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
    // await widget.instrument.fetchFieldsForInstrument();
    widget.setPages(pages);

    // Check if its a demographics form
    if (widget.instrument.isDemographic()) {
      // If there is a form completed, fill the fields
      if (widget.instrument.getForms().isNotEmpty) {
        widget.instrument.fillFieldsFromForm(0);
      }
    } else {
      // Otherwise check if a form index was chosen
      var formIndex = widget.instrument.getFormIndex();
      printLog(formIndex.toString());
      if (formIndex != null) {
        // Fill the fields from the selected form
        widget.instrument.fillFieldsFromForm(formIndex);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : Form(
            autovalidateMode: AutovalidateMode.disabled,
            child: PageView(
              controller: widget.controller,
              physics:
                  NeverScrollableScrollPhysics(), // Disable swipe navigation
              children: pages,
            ),
          );
  }
}
