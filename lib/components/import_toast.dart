import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void createToast(String message, Color backgroundColor) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

void showImportToast() {
  createToast("Import was successful", Colors.green);
}

void showImportErrorToast() {
  createToast("Error occurred during import", Colors.red);
}

void showInvalidFormToast(String field) {
  createToast('Field $field is required', Colors.red);
}

void createAudiogamTimingToast() {
  createToast("Audiogram Timing Updated", Colors.blue);
}
