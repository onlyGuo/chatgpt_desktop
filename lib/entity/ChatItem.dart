class ChatItem {

  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String lastMessageTime;

  ChatItem({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  // toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'lastMessage': lastMessage,
    'lastMessageTime': lastMessageTime,
  };

  // fromJson
  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
    );
  }

}
