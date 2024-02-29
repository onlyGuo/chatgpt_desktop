import 'dart:convert';

import 'package:chatgpt_desktop/entity/ChatSimpleItem.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:get/get.dart';

class ChatHistoryController extends GetxController{
  var selectedChatId = ''.obs;

  RxList<ChatSimpleItem> items = RxList<ChatSimpleItem>([]);

  void addChat() => {
    items.add(ChatSimpleItem(id: DateTime.now().millisecondsSinceEpoch.toString(), avatar: '', name: 'New Chat', lastMessage: '', lastMessageTime: '')),
    Util.writeFile('history.json', jsonEncode(items)),
    update()
  };

  void removeChat(ChatSimpleItem chat) => {
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
          ChatSimpleItem(id: '0', avatar: '', name: 'New Chat', lastMessage: '', lastMessageTime: ''),
        ]);
        Util.writeFile('history.json', value);
        selectedChatId.value = '0';
      }
      jsonDecode(value).map<ChatSimpleItem>((item) => ChatSimpleItem.fromJson(item)).toList().forEach((element) {
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

  void updateChatName(String id, String name){
    items.firstWhere((element) => element.id == id).name = name;
    items.refresh();
    Util.writeFile('history.json', jsonEncode(items));
    update();
  }

  void updateChatAvatar(String id, String value) {
    items.firstWhere((element) => element.id == id).avatar = value;
    items.refresh();
    Util.writeFile('history.json', jsonEncode(items));
    update();
  }

}

