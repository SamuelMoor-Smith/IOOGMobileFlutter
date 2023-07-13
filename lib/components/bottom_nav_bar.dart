import 'package:flutter/material.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/navigation.dart';
import 'package:namer_app/utils/logging.dart';

import '../models/section.dart';
import '../pages/survey_pages/ioog_page.dart';

void animateToPage(PageController controller, int nextPage) {
  try {
    controller.animateToPage(
      nextPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  } catch (e) {
    printError(e.toString());
  }
}

int getNextPageNumber(
    PageController? controller, List<IOOGPage>? pages, int difference) {
  if (controller != null && controller.hasClients) {
    int currentPageIndex = controller.page!.round();
    int nextPageNumber = currentPageIndex + difference;
    while (
        pages != null && nextPageNumber >= 0 && nextPageNumber < pages.length) {
      if (pages[nextPageNumber].isVisible()) {
        return nextPageNumber;
      }
      nextPageNumber += difference;
    }
  }
  return -1;
}

BottomNavigationBar createBottomNavigationBar(BuildContext context,
    IOOGSection section, Widget forward, FormManager formManager,
    [PageController? controller, List<IOOGPage>? pages]) {
  void onItemTapped(int index) {
    int nextPageNumber;
    if (index == 0) {
      // Back Button was pressed
      nextPageNumber = getNextPageNumber(controller, pages, -1);
      if (nextPageNumber >= 0) {
        animateToPage(controller!, nextPageNumber);
      } else {
        Navigator.pop(context);
      }
    } else {
      // Forward Button was pressed
      if (formManager.sectionIsValid(section)) {
        nextPageNumber = getNextPageNumber(controller, pages, 1);
        if (nextPageNumber >= 0) {
          animateToPage(controller!, nextPageNumber);
        } else {
          nextPage(context, forward);
        }
      } else {
        printError("Form is not valid");
      }
    }
  }

  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.arrow_back),
        label: 'Back',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.arrow_forward),
        label: 'Forward',
        backgroundColor: Colors.blue,
      ),
    ],
    onTap: onItemTapped,
  );
}
