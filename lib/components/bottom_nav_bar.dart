import 'package:flutter/material.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:namer_app/utils/navigation.dart';
import 'package:namer_app/utils/logging.dart';

import '../models/section.dart';

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
    PageController? controller, int pageLength, int difference) {
  if (controller != null && controller.hasClients) {
    final nextPageNumber = controller.page!.round() + difference;
    if (nextPageNumber >= 0 && nextPageNumber < pageLength) {
      return nextPageNumber;
    }
  }
  return -1;
}

BottomNavigationBar createBottomNavigationBar(BuildContext context,
    IOOGSection section, Widget forward, FormManager formManager,
    [PageController? controller, int pageLength = 1]) {
  void _onItemTapped(int index) {
    int nextPageNumber;
    if (index == 0) {
      // Back Button was pressed
      nextPageNumber = getNextPageNumber(controller, pageLength, -1);
      if (nextPageNumber >= 0) {
        animateToPage(controller!, nextPageNumber);
      } else {
        Navigator.pop(context);
      }
    } else {
      // Forward Button was pressed
      if (formManager.sectionIsValid(section)) {
        nextPageNumber = getNextPageNumber(controller, pageLength, 1);
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
    onTap: _onItemTapped,
  );
}
