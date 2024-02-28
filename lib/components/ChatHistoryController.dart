import 'dart:convert';

import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:get/get.dart';
import 'package:chatgpt_desktop/entity/ChatItem.dart';

class ChatHistoryController extends GetxController{
  var selectedChatId = ''.obs;

  RxList<ChatItem> items = RxList<ChatItem>([]);

  void addChat() => {
    items.add(ChatItem(id: DateTime.now().millisecondsSinceEpoch.toString(), avatar: '', name: 'New Chat', lastMessage: '', lastMessageTime: '')),
    Util.writeFile('history.json', jsonEncode(items)),
    update()
  };

  void removeChat(ChatItem chat) => {
    items.remove(chat),
    Util.writeFile('history.json', jsonEncode(items)),
    update()
  };

  @override
  void onReady() {
    // 从本地存储中获取
    Util.readFile('history.json').then((value) {
      if(value.isEmpty){
        value = jsonEncode([
          ChatItem(id: '0', avatar: '', name: 'New Chat', lastMessage: '', lastMessageTime: ''),
        ]);
        Util.writeFile('history.json', value);
        selectedChatId.value = '0';
      }
      jsonDecode(value).map<ChatItem>((item) => ChatItem.fromJson(item)).toList().forEach((element) {
        items.add(element);
      });
      update();  // 通知 Flutter 刷新 UI
    });
    super.onReady();
  }

  void selectChat(String id){
    selectedChatId.value = id;
    update();
  }

}

