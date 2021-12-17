class FastingInfo {
  Duration? duration;
  String type;
  DateTime dateStart;
  DateTime? dateEnd;
  DateTime? goal;
  String? note;

  FastingInfo({
    required this.duration,
    required this.type,
    required this.dateStart,
    this.goal,
    this.note,
    this.dateEnd,
  });
}
