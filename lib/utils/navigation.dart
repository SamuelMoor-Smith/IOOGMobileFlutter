import 'package:flutter/material.dart';

void nextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
  );
}
