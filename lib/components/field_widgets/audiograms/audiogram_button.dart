import 'package:flutter/material.dart';

abstract class AudiogramButton extends StatefulWidget {

  final String field;
  final String value;

  final double left;
  final double top;
  final double width;
  final double height;

  AudiogramButton({
    Key? key,
    required this.field,
    required this.value,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  }) : super( key: key, );
  
  void selectButton() {
    
  }
}

