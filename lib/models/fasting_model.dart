class FastingInfo {
  Duration? duration;
  String type;
  DateTime dateStart;
  DateTime? dateEnd;
  String? note;

  FastingInfo({
    required this.duration,
    required this.type,
    required this.dateStart,
    this.note,
    this.dateEnd,
  });
}
