import 'package:flutter/material.dart';

import '../../utils/form_manager.dart';
import '../field_widgets/multiple_choice/radio_button.dart';
import '../image_buttons/rectangle.dart';
import 'package:namer_app/models/choice.dart';
import '../../../models/field/field.dart';

class OssicularChain extends IOOGRadioGroup {
  OssicularChain({
    Key? key,
    required Field field,
    required FormManager formKeyManager,
    required Set<Choice> choices,
  }) : super(
          key: key,
          choices: choices,
          field: field,
          formKeyManager: formKeyManager,
        );

  @override
  State<OssicularChain> createState() => _OssicularChainState();
}

class _OssicularChainState extends State<OssicularChain> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.shouldShow,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/ossicularchain_w_ou.png'),
              width: 260,
              height: 445.6,
            ),
            Rectangle(
                group: widget,
                name: "On Intact chain preservation",
                left: 1,
                top: 1.1,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ou Previous ossicular surgery undisturbed",
                left: 97.5,
                top: 1.1,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ox  Abnormal chain, No reconstruction",
                left: 193,
                top: 1.1,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Osi  Incus to stapes superstructure",
                left: 1,
                top: 112,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Osm  Malleus to stapes superstructure",
                left: 65,
                top: 112,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ost  TM to stapes superstructure",
                left: 129,
                top: 112,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name:
                    "Osd  TM directly on stapes superstructure (eg myringostapediopexy)",
                left: 193,
                top: 112,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ofi  Incus to footplate",
                left: 1,
                top: 223.2,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ofm  Malleus to footplate",
                left: 65,
                top: 223.2,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Oft  TM to footplate",
                left: 129,
                top: 223.2,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ofd  TM directly on footplate",
                left: 193,
                top: 223.2,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ovi  Incus to vestibule (eg stapedotomy)",
                left: 1,
                top: 336.23,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ovm  Malleus to vestibule",
                left: 65,
                top: 336.23,
                width: 62,
                height: 86),
            Rectangle(
                group: widget,
                name: "Ovt  TM to vestibule",
                left: 129,
                top: 336.23,
                width: 62,
                height: 86),
          ],
        ),
      ),
    );
  }
}
