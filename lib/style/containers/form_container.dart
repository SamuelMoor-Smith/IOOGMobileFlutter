import 'package:flutter/material.dart';

class FormContainer extends StatelessWidget {
  final Widget child;

  FormContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
