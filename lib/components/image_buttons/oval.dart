import 'package:flutter/material.dart';

class Oval extends StatefulWidget {
  final double left;
  final double top;
  final double width;
  final double height;

  Oval({required this.left, required this.top, required this.width, required this.height});

  @override
  _OvalState createState() => _OvalState();
}

class _OvalState extends State<Oval> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });
            print("Button pressed");
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.elliptical(widget.width / 2, widget.height / 2),
              ),
              border: Border.all(
                color: _isSelected ? Colors.green : Colors.black,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
