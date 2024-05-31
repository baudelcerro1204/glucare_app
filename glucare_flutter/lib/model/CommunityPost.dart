class CommunityPost {
  final int? id;
  final String userName;
  final String content;
  final DateTime date;

  CommunityPost({this.id, required this.userName, required this.content, required this.date});

  factory CommunityPost.fromJson(Map<String, dynamic> json) {
    return CommunityPost(
      id: json['id'],
      content: json['content'],
      userName: json['userName'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'content': content,
      'date': date.toIso8601String(),
    };
  }
}
