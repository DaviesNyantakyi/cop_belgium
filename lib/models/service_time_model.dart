// ignore_for_file: public_member_api_docs, sort_constructors_first

class ServiceTimeModel {
  String? day;
  String description;
  DateTime time;

  ServiceTimeModel({
    required this.day,
    required this.time,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'description': description,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ServiceTimeModel.fromMap(Map<String, dynamic> map) {
    return ServiceTimeModel(
      day: map['day'],
      description: map['description'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }
}
