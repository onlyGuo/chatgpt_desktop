class ChatSimpleItem {

  String id;
  String name;
  String avatar;
  String lastMessage;
  String lastMessageTime;

  ChatSimpleItem({
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
  ChatSimpleItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'],
        lastMessage = json['lastMessage'],
        lastMessageTime = json['lastMessageTime'];


}
