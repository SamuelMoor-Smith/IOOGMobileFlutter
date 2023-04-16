import 'package:flutter/material.dart';

class Rectangle extends StatefulWidget {
  final double left;
  final double top;
  final double width;
  final double height;

  Rectangle({required this.left, required this.top, required this.width, required this.height});

  @override
  _RectangleState createState() => _RectangleState();
}

class _RectangleState extends State<Rectangle> {
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
