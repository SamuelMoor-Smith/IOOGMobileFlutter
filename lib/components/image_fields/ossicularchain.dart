import 'package:flutter/material.dart';

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
                '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/ossicularchain_w_ou.png'),
            width: 260,
            height: 445.6,
          ),
          Rectangle(left: 1, top: 1.1, width: 62, height: 86),
          Rectangle(left: 97.5, top: 1.1, width: 62, height: 86),
          Rectangle(left: 193, top: 1.1, width: 62, height: 86),
          Rectangle(left: 1, top: 112, width: 62, height: 86),
          Rectangle(left: 65, top: 112, width: 62, height: 86),
          Rectangle(left: 129, top: 112, width: 62, height: 86),
          Rectangle(left: 193, top: 112, width: 62, height: 86),
          Rectangle(left: 1, top: 223.2, width: 62, height: 86),
          Rectangle(left: 65, top: 223.2, width: 62, height: 86),
          Rectangle(left: 129, top: 223.2, width: 62, height: 86),
          Rectangle(left: 193, top: 223.2, width: 62, height: 86),
          Rectangle(left: 1, top: 336.23, width: 62, height: 86),
          Rectangle(left: 65, top: 336.23, width: 62, height: 86),
          Rectangle(left: 129, top: 336.23, width: 62, height: 86),
        ],
      ),
    );
  }
}
