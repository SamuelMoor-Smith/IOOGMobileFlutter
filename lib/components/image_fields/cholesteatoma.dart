import 'package:flutter/material.dart';

import '../image_buttons/oval.dart';
import '../image_buttons/rectangle.dart';

class Cholesteatoma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Image(
            image: AssetImage(
                '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/cholesteatoma.png'),
            width: 260,
            height: 173,
          ),
          Rectangle(left: 18, top: 52, width: 51, height: 16),
          Rectangle(left: 176, top: 52, width: 62, height: 16),
          Oval(left: 10, top: 111, width: 47, height: 20),
          Oval(left: 85, top: 111, width: 45, height: 20),
          Oval(left: 132, top: 108, width: 62, height: 27),
          Oval(left: 195, top: 109, width: 65, height: 25),
          Oval(left: 24, top: 129, width: 96, height: 24),
        ],
      ),
    );
  }
}
