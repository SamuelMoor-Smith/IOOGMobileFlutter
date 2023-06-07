import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/services/form_key_manager.dart';
import 'package:namer_app/utils.dart';

void animateToPage(PageController controller, int nextPage) {
  controller.animateToPage(
    nextPage,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );
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

BottomNavigationBar createBottomNavigationBar(
    BuildContext context, Widget forward, FormKeyManager formKeyManager,
    [PageController? controller, int pageLength = 1]) {
  void _onItemTapped(int index) {
    int nextPageNumber;
    if (index == 0) {
      nextPageNumber = getNextPageNumber(controller, pageLength, -1);
      if (nextPageNumber >= 0) {
        animateToPage(controller!, nextPageNumber);
      } else {
        Navigator.pop(context);
      }
    } else {
      if (formKeyManager.formIsValid()) {
        nextPageNumber = getNextPageNumber(controller, pageLength, 1);
        if (nextPageNumber >= 0) {
          animateToPage(controller!, nextPageNumber);
        } else {
          nextPage(context, forward);
        }
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
