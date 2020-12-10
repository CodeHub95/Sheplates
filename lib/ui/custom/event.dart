/// Event for the date pickers.
class Event {
  /// Event's date.
  final DateTime date;

  /// Event's title.
  final String dis;

  bool isActive;

  ///
  Event(this.date, this.dis, {this.isActive})
      : assert(date != null),
        assert(dis != null);
}
