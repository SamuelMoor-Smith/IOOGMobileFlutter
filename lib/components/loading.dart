import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: 75.0,
          height: 75.0,
          child: Center(
            child: SpinKitRotatingPlain(
              color: Theme.of(context).primaryColor,
              size: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
