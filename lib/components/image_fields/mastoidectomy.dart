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
                '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/mastoidectomy_w_mu.png'),
            width: 260,
            height: 440,
          ),
          Rectangle(left: 1, top: 1.3, width: 85, height: 65.8),
          Rectangle(left: 87, top: 1.3, width: 85, height: 65.8),
          Rectangle(left: 1, top: 83.7, width: 85, height: 65.8),
          Rectangle(left: 87, top: 83.7, width: 85, height: 65.8),
          Rectangle(left: 1, top: 167, width: 85, height: 65.8),
          Rectangle(left: 87, top: 167, width: 85, height: 65.8),
          Rectangle(left: 174, top: 167, width: 85, height: 65.8),
          Rectangle(left: 1, top: 257.6, width: 85, height: 65.8),
          Rectangle(left: 87, top: 257.6, width: 85, height: 65.8),
          Rectangle(left: 1, top: 349.7, width: 85, height: 65.8),
          Rectangle(left: 87, top: 349.7, width: 85, height: 65.8),
        ],
      ),
    );
  }
}
