class TestimonyInfo {
  String? id;
  final String userId;
  String? title;
  final String? userName;
  String? description;
  int? likes;
  final DateTime? date;
  // String? cardColor;
  final bool isAnonymous;

  TestimonyInfo({
    this.id,
    this.userName,
    required this.isAnonymous,
    required this.userId,
    required this.title,
    required this.description,
    this.likes,
    required this.date,
    // this.cardColor,
  });

  static Map<String, dynamic> toMap({required TestimonyInfo map}) {
    return {
      'id': map.id,
      'userName': map.userName,
      'userId': map.userId,
      'isAnonymous': map.isAnonymous,
      'title': map.title,
      'description': map.description,
      'likes': map.likes,
      'date': map.date,
      // 'cardColor': map.cardColor,
    };
  }

  static TestimonyInfo fromMap({required Map<String, dynamic> map}) {
    return TestimonyInfo(
      id: map['id'],
      userName: map['userName'],
      userId: map['userId'],
      title: map['title'],
      isAnonymous: map['isAnonymous'],
      description: map['description'],
      date: map['date'].toDate(),
      // cardColor: map['cardColor'],
      likes: map['likes'],
    );
  }
}
