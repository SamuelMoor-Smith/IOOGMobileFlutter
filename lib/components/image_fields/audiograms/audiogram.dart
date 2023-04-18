import 'package:flutter/material.dart';
import 'package:namer_app/components/field_widgets/audiograms/leac.dart';
import 'package:namer_app/components/field_widgets/audiograms/lebc.dart';
import 'package:namer_app/components/field_widgets/audiograms/reac.dart';

import '../../field_widgets/audiograms/rebc.dart';

class Audiogram extends StatefulWidget {

  final double TOP_INIT = 100;
  final double LEFT_INIT = 44.8;
  final double TOP_DIFF = 44.7/2;
  final double LEFT_DIFF = 31;

  final String type;

  Audiogram({Key? key, required this.type}) : super(key: key);

  @override
  State<Audiogram> createState() => _AudiogramState();

  List<Widget> createButtons() {
    List<Widget> buttons = [];
    for (int i = 0; i < 7; i++) {
      for (int j = 0; j < 21; j++) {
        // Add group dependant on i
        String value = (i * 5).toString();
        double left = LEFT_INIT + i * LEFT_DIFF;
        double top = TOP_INIT + j * TOP_DIFF;
        Widget? button;
        switch (type) {
          case 'reac':
            button = REACButton(field: '$type$i', value: value, left: left, top: top, width: 10, height: 10);
            break;
          case 'rebc':
            button = REBCButton(field: '$type$i', value: value, left: left, top: top, width: 10, height: 10);
            break;
          case 'leac':
            button = LEACButton(field: '$type$i', value: value, left: left, top: top, width: 10, height: 10);
            break;
          case 'lebc':
            button = LEBCButton(field: '$type$i', value: value, left: left, top: top, width: 10, height: 10);
            break;
        }
        if (button != null) {
          buttons.add(button);
        }
      }
    }
    return buttons;
  }
}

class _AudiogramState extends State<Audiogram> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audiogram"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(
                        '/Users/samuelmoor-smith/IOOGMobileFlutter/assets/images/audiogram_small.png'),
                    width: 250,
                    height: 575,
                  ),
                  ...widget.createButtons(),
                ],
              ),
            ),
          ),
        ]
      ));
  }
}
