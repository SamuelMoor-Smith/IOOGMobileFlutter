import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/field/field.dart';
import 'package:namer_app/utils/form_manager.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../style/containers/field_container.dart';
import '../../style/text/title_list_tile.dart';
import '../../utils/logging.dart';

abstract class IOOGFieldWidget extends StatefulWidget {
  final Field field;
  final FormManager formManager;
  bool shouldShow = true;
  bool isUpdating = false;

  IOOGFieldWidget({Key? key, required this.field, required this.formManager})
      : super(key: key);

  String? isValid() {
    printLog('${getFieldName()} being checked...');
    if (shouldShow && isRequired()) {
      if (isFilled()) {
        return null;
      } else {
        return '${getFieldLabel()} is required';
      }
    } else {
      return null;
    }
  }

  Field getField() {
    return field;
  }

  String getFieldLabel() {
    return field.getFieldLabel();
  }

  String getFieldName() {
    return field.getFieldName();
  }

  String getFieldType() {
    return field.getFieldType();
  }

  bool isRequired() {
    return field.isRequired();
  }

  String getLabelText() {
    return field.getLabelText();
  }

  String getSectionHeader() {
    return field.getSectionHeader();
  }

  String getParsedBranchingLogic() {
    return field.getParsedBranchingLogic();
  }

  bool isFilled();
  void updateForm();
  void fillField(dynamic rawRecord);
  void clearField();

  void checkBranchingLogic(setState, mounted) {
    printLog(field.getFieldName());
    String branchingLogic = field.getParsedBranchingLogic();
    if (!branchingLogic.isEmptyOrNull) {
      var expression = Expression.parse(branchingLogic);
      try {
        shouldShow = formManager.shouldShow(expression);
        if (mounted) {
          setState(() {
            shouldShow = shouldShow;
          });
        }
      } catch (e) {
        printError(
            "Error evaluating branching logic for ${field.getFieldLabel()}: ${e.toString()}");
      }
    }
  }

  @override
  IOOGFieldWidgetState<IOOGFieldWidget> createState();
}

abstract class IOOGFieldWidgetState<T extends IOOGFieldWidget>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    widget.checkBranchingLogic(setState, mounted);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.checkBranchingLogic(setState, mounted);
    });
    widget.formManager
        .getFormStateNotifier()
        .addListener(() => widget.checkBranchingLogic(setState, mounted));
  }

  @override
  void dispose() {
    widget.formManager
        .getFormStateNotifier()
        .removeListener(() => widget.checkBranchingLogic(setState, mounted));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.shouldShow,
      child: FieldContainer(
        child: Column(children: [
          TitleListTile(
            labelText: widget.getLabelText(),
            fieldNote: widget.field.field_note,
          ),
          ...buildFieldWidgets(),
        ]),
      ),
    );
  }

  List<Widget> buildFieldWidgets() {
    return [];
  }
}
