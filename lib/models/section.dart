import '../components/field_widgets/field_widget.dart';

class IOOGSection {
  String _label;
  List<IOOGFieldWidget> _fields = [];

  IOOGSection(this._label);

  void addFieldWidget(IOOGFieldWidget fieldWidget) {
    _fields.add(fieldWidget);
  }

  List<IOOGFieldWidget> getFields() {
    return _fields;
  }

  String getLabel() {
    return _label;
  }
}
