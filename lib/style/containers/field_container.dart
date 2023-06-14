import 'package:flutter/material.dart';
import 'package:namer_app/style/containers/border.dart';

class FieldContainer extends StatelessWidget {
  final Widget child;
  // final EdgeInsetsGeometry margin;
  // final BoxDecoration decoration;

  FieldContainer({
    required this.child,
    // this.margin = const EdgeInsets.symmetric(vertical: 10.0),
    // this.decoration = const BoxDecoration(
    //   border: Border.all(color: Colors.grey),
    //   borderRadius: BorderRadius.circular(10.0),
    // ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: bordered,
      child: child,
    );
  }
}
