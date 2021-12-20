class TestimonyInfo {
  String? id;
  final String userId;
  String? title;
  final String? userName;
  String? testimony;
  int? likes;
  final DateTime? date;
  String? cardColor;
  final bool anonymous;

  TestimonyInfo({
    this.id,
    this.userName,
    required this.anonymous,
    required this.userId,
    required this.title,
    required this.testimony,
    this.likes,
    required this.date,
    this.cardColor,
  });

  static Map<String, dynamic> toMap({required TestimonyInfo map}) {
    return {
      'id': map.id,
      'userName': map.userName,
      'userId': map.userId,
      'anonymous': map.anonymous,
      'title': map.title,
      'testimony': map.testimony,
      'likes': map.likes,
      'date': map.date,
      'cardColor': map.cardColor,
    };
  }

  static TestimonyInfo fromMap({required Map<String, dynamic> map}) {
    return TestimonyInfo(
      id: map['id'],
      userName: map['userName'],
      userId: map['userId'],
      title: map['title'],
      anonymous: map['anonymous'],
      testimony: map['testimony'],
      date: map['date'].toDate(),
      cardColor: map['cardColor'],
      likes: map['likes'],
    );
  }
}
