import 'package:flutter/material.dart';
import 'package:namer_app/components/loading.dart';
import 'package:namer_app/models/section.dart';
import 'package:namer_app/pages/survey_pages/ioog_page.dart';
import 'package:provider/provider.dart';
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

  Future<void> setPages(List<IOOGPage> pages) async {
    List<IOOGSection> sections = await instrument.getSections();
    for (IOOGSection section in sections) {
      pages.add(IOOGPage(
        section: section,
        instrument: instrument,
        controller: controller,
        pages: pages,
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
    await widget.setPages(pages);

    // Check if its a demographics form
    if (widget.instrument.isDemographic()) {
      printLog("Sam isdemo");
      // If there is a form completed, fill the fields
      while (widget.instrument.isLoading() != null) {
        await Future.delayed(Duration(milliseconds: 100));
      }
      printLog("Sam isLoading");
      printLog(widget.instrument.isLoading());
      if (widget.instrument.getForms().isNotEmpty) {
        printLog("Sam I am here");
        await widget.instrument.fillFieldsFromForm(0);
      }
    } else {
      // Otherwise check if a form index was chosen
      var formIndex = widget.instrument.getFormIndex();
      if (formIndex != null) {
        // Fill the fields from the selected form
        await widget.instrument.fillFieldsFromForm(formIndex).then((value) =>
            printLog(
                'form filled: ${widget.instrument.getFormManager().getFormStateNotifier().value}'));
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.instrument,
        child: Consumer<IOOGInstrument>(builder: (context, instrument, child) {
          if (instrument.isLoading() != null || _isLoading) {
            return Loading();
          } else {
            return PageView(
              controller: widget.controller,
              physics:
                  NeverScrollableScrollPhysics(), // Disable swipe navigation
              children: pages,
            );
          }
        }));
  }
}
