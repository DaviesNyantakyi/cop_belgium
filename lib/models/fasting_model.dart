class FastingInfo {
  String? id;
  String? userId;
  Duration duration;
  String type;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? goalDate;
  String? note;

  FastingInfo({
    this.id,
    this.userId,
    required this.duration,
    required this.type,
    this.startDate,
    this.endDate,
    this.goalDate,
    this.note,
  });

  static Map<String, dynamic> toMap({required FastingInfo map}) {
    return {
      'id': map.id,
      'userId': map.userId,
      'duration': map.duration.inSeconds,
      'type': map.type,
      'startDate': map.startDate,
      'endDate': map.endDate,
      'goalDate': map.goalDate,
      'note': map.note,
    };
  }

  static FastingInfo fromMap({required Map<String, dynamic> map}) {
    return FastingInfo(
      id: map['id'],
      userId: map['userId'],
      duration: Duration(seconds: int.parse(map['duration'].toString())),
      type: map['type'],
      startDate: map['startDate'].toDate(),
      endDate: map['endDate'].toDate(),
      goalDate: map['goalDate'].toDate(),
      note: map['note'],
    );
  }
}
