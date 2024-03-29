import 'package:flutter/material.dart';

class FieldContainer extends StatefulWidget {
  final Widget child;
  final bool isSelected;

  FieldContainer({
    required this.child,
    this.isSelected = false,
  });

  @override
  _FieldContainerState createState() => _FieldContainerState();
}

class _FieldContainerState extends State<FieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
            width: 8, color: widget.isSelected ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: widget.child,
    );
  }
}
