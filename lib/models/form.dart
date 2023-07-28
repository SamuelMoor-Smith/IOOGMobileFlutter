class IOOGForm {
  String _side;
  String _date;
  dynamic _record;

  IOOGForm(this._date, this._side, this._record);

  String getSideString() {
    if (_side == "1") {
      return "Right Ear";
    } else {
      return "Left Ear";
    }
  }

  @override
  String toString() {
    return '$_date - ${getSideString()}';
  }

  dynamic getRecord() {
    return _record;
  }
}
