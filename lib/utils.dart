import 'package:flutter/material.dart';

void nextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
  );
}

void printError(text) {
  debugPrint("ERROR: $text");
}

void printLog(text) {
  debugPrint("LOG: $text");
}
