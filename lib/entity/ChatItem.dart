import 'package:chatgpt_desktop/entity/ChatMessage.dart';

class ChatItem {

  String id;
  String name;
  String avatar;
  String subtitle;
  String system;
  List<String> plugins;
  double temperature;
  int dialogCount;
  List<ChatMessage> history;
  String lastMessage;
  String lastMessageTime;

  ChatItem({
    required this.id,
    required this.name,
    required this.avatar,
    this.subtitle = "",
    this.system = "",
    this.plugins = const [],
    this.dialogCount = 5,
    this.temperature = 0.8,
    this.history = const [],
    required this.lastMessage,
    required this.lastMessageTime,
  });

  // toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    'subtitle': subtitle,
    'system': system,
    'plugins': plugins,
    'temperature': temperature,
    'dialogCount': dialogCount,
    'history': history,
    'lastMessage': lastMessage,
    'lastMessageTime': lastMessageTime,
  };

  // fromJson
  static ChatItem fromJson(Map<String, dynamic> json) {
    return ChatItem(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      subtitle: json['subtitle'],
      system: json['system'],
      plugins: List<String>.from(json['plugins']),
      temperature: json['temperature'],
      dialogCount: json['dialogCount'],
      history: List<ChatMessage>.from(json['history'].map((item) => ChatMessage.fromJson(item))),
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
    );
  }


}
