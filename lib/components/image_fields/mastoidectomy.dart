import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../services/form_key_manager.dart';
import '../field_widgets/multiple_choice/radio_button.dart';
import '../image_buttons/rectangle.dart';
import 'package:namer_app/models/choice.dart';
import '../../../models/field/field.dart';

class Mastoidectomy extends IOOGRadioGroup {
  Mastoidectomy({
    Key? key,
    required Field field,
    required FormKeyManager formKeyManager,
    required Set<Choice> choices,
  }) : super(
          key: key,
          choices: choices,
          field: field,
          formKeyManager: formKeyManager,
        );

  @override
  State<Mastoidectomy> createState() => _MastoidectomyState();
}

class _MastoidectomyState extends State<Mastoidectomy> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.shouldShow,
      child: FormBuilderField(
          name: widget.getFieldName(),
          validator: widget.validator(),
          builder: (FormFieldState<dynamic> state) {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Image(
                    image: AssetImage('assets/images/mastoidectomy_w_mu.png'),
                    width: 260,
                    height: 440,
                  ),
                  Rectangle(
                      group: widget,
                      name: "Mx  No mastoid surgery",
                      left: 1,
                      top: 1.3,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name: "Mu Previous mastoid surgery undisturbed",
                      left: 87,
                      top: 1.3,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name:
                          "M1a Canal wall preserved (aka cortical mastoidectomy)",
                      left: 1,
                      top: 83.7,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name: "M1b  As M1a + posterior tympanotomy",
                      left: 87,
                      top: 83.7,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name: "M2a  Only scutum removed (aka atticotomy)",
                      left: 1,
                      top: 167,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name:
                          "M2b  Scutum + posterosuperior wall removed (aka atticoantrostomy)",
                      left: 87,
                      top: 167,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name:
                          "M2c  Whole canal wall removed (eg modified radical mastoidectomy)",
                      left: 174,
                      top: 167,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name:
                          "M1a + M2a  Scutum removal + cortical mastoidectomy",
                      left: 1,
                      top: 257.6,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name: "M1b + M2a  As above with posterior tympanotomy",
                      left: 87,
                      top: 257.6,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name:
                          "M3a  Subtotal petrosectomy, otic capsule preserved",
                      left: 1,
                      top: 349.7,
                      width: 85,
                      height: 65.8),
                  Rectangle(
                      group: widget,
                      name: "M3b  Subtotal petrosectomy + removal otic capsule",
                      left: 87,
                      top: 349.7,
                      width: 85,
                      height: 65.8),
                ],
              ),
            );
          }),
    );
  }
}
