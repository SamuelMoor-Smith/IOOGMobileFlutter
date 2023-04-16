import 'package:flutter/material.dart';

import '../image_buttons/oval.dart';

class Diagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Image(
            image: AssetImage(
                '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/diagram.jpg'),
            width: 260,
            height: 184,
          ),
          Oval(left: 31, top: 61, width: 40, height: 40),
          Oval(left: 80, top: 34, width: 40, height: 40),
          Oval(left: 172, top: 46, width: 40, height: 40),
          Oval(left: 80, top: 112, width: 40, height: 40),
          Oval(left: 130, top: 92, width: 40, height: 40),
          Oval(left: 178, top: 107, width: 40, height: 40),
        ],
      ),
    );
  }
}