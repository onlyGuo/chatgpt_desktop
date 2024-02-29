class ChatMessage {
  final String content;
  final String role;
  final String time;

  ChatMessage({
    required this.content,
    required this.role,
    required this.time,
  });

  // toJson
  Map<String, dynamic> toJson() => {
    'content': content,
    'role': role,
    'time': time,
  };

  // fromJson
  ChatMessage.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        role = json['role'],
        time = json['time'];
}