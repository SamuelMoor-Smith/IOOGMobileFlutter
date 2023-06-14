class IOOGForm {
  String _side;
  String _date;
  dynamic _record;

  IOOGForm(this._date, this._side, this._record);

  @override
  String toString() {
    return '$_date - $_side';
  }

  dynamic getRecord() {
    return _record;
  }
}
