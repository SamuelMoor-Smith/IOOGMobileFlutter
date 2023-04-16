import 'package:flutter/material.dart';

import '../components/image_buttons/oval.dart';
import '../components/image_buttons/rectangle.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Page"),
      ),
      body: Column(
        children: [
          Padding(
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
          ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Stack(
          //     children: [
          //       Image(
          //         image: AssetImage(
          //             '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/mastoidectomy_w_mu.png'),
          //         width: 260,
          //         height: 440,
          //       ),
          //       Rectangle(left: 1, top: 1.3, width: 85, height: 65.8),
          //       Rectangle(left: 87, top: 1.3, width: 85, height: 65.8),
          //       Rectangle(left: 1, top: 83.7, width: 85, height: 65.8),
          //       Rectangle(left: 87, top: 83.7, width: 85, height: 65.8),
          //       Rectangle(left: 1, top: 167, width: 85, height: 65.8),
          //       Rectangle(left: 87, top: 167, width: 85, height: 65.8),
          //       Rectangle(left: 174, top: 167, width: 85, height: 65.8),
          //       Rectangle(left: 1, top: 257.6, width: 85, height: 65.8),
          //       Rectangle(left: 87, top: 257.6, width: 85, height: 65.8),
          //       Rectangle(left: 1, top: 349.7, width: 85, height: 65.8),
          //       Rectangle(left: 87, top: 349.7, width: 85, height: 65.8),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Stack(
          //     children: [
          //       Image(
          //         image: AssetImage(
          //             '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/ossicularchain_w_ou.png'),
          //         width: 260,
          //         height: 445.6,
          //       ),
          //       Rectangle(left: 1, top: 1.1, width: 62, height: 86),
          //       Rectangle(left: 97.5, top: 1.1, width: 62, height: 86),
          //       Rectangle(left: 193, top: 1.1, width: 62, height: 86),
          //       Rectangle(left: 1, top: 112, width: 62, height: 86),
          //       Rectangle(left: 65, top: 112, width: 62, height: 86),
          //       Rectangle(left: 129, top: 112, width: 62, height: 86),
          //       Rectangle(left: 193, top: 112, width: 62, height: 86),
          //       Rectangle(left: 1, top: 223.2, width: 62, height: 86),
          //       Rectangle(left: 65, top: 223.2, width: 62, height: 86),
          //       Rectangle(left: 129, top: 223.2, width: 62, height: 86),
          //       Rectangle(left: 193, top: 223.2, width: 62, height: 86),
          //       Rectangle(left: 1, top: 336.23, width: 62, height: 86),
          //       Rectangle(left: 65, top: 336.23, width: 62, height: 86),
          //       Rectangle(left: 129, top: 336.23, width: 62, height: 86),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Stack(
          //     children: [
          //       Image(
          //         image: AssetImage(
          //             '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/diagram.jpg'),
          //         width: 260,
          //         height: 184,
          //       ),
          //       Oval(left: 31, top: 61, width: 40, height: 40),
          //       Oval(left: 80, top: 34, width: 40, height: 40),
          //       Oval(left: 172, top: 46, width: 40, height: 40),
          //       Oval(left: 80, top: 112, width: 40, height: 40),
          //       Oval(left: 130, top: 92, width: 40, height: 40),
          //       Oval(left: 178, top: 107, width: 40, height: 40),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
