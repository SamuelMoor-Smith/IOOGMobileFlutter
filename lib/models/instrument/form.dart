class IOOGForm {

  String side;
  String date;
  dynamic record;

  IOOGForm(this.date, this.side, this.record);

  @override
  String toString() {
    return '$date - $side';
  }

  dynamic getRecord() {
    return record;
  }
}