import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:namer_app/utils.dart';

BottomNavigationBar createBottomNavigationBar(
  BuildContext context, 
  Widget forward,
  [GlobalKey<FormBuilderState>? formKey, PageController? controller, int pageLength = 1]) 
{
  void _onItemTapped(int index) {
    if (index == 0) {
      if (controller != null && controller.hasClients && controller.page! > 0) {
        controller.animateToPage(
          controller.page!.round() - 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.pop(context);
      }
    } else {
      bool isFormValid = formKey == null || formKey.currentState!.validate();
      debugPrint('Form is valid: $isFormValid');
      if (!isFormValid) {
        formKey.currentState!.fields.forEach((fieldName, field) {
          if (field.validate() != null) {
            debugPrint('Field "$fieldName" had validation with message: ${field.validate()}');
          }
        });
      }
      // Validate returns true if the form is valid, or false otherwise.
      if (formKey == null || formKey.currentState!.validate()) {
        if (controller != null && controller.hasClients && controller.page! < pageLength - 1) {
        controller.animateToPage(
          controller.page!.round() + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
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