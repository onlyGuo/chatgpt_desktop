import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chatgpt_desktop/components/chat/ChatInput.dart';
import 'package:chatgpt_desktop/components/chat/ChatSettingController.dart';
import 'package:chatgpt_desktop/components/chat/ChatSettings.dart';
import 'package:chatgpt_desktop/components/chat/ChatTitle.dart';
import 'package:chatgpt_desktop/components/chat/message/ChatMessage.dart';
import 'package:chatgpt_desktop/controller/SettingController.dart';
import 'package:chatgpt_desktop/entity/ChatItem.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {

  final String id;

  Chat({super.key, required this.id});

  ChatSettingController controller = Get.put(ChatSettingController());
  SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {

    Util.readFile('chats/$id.json').then((value) {
      if(value.isEmpty){
        value = jsonEncode(ChatItem(id: id, name: "New Chat", avatar: "", lastMessage: "", lastMessageTime: "", subtitle: "Empty Description"));
        Util.writeFile('chats/$id.json', value);
      }
      controller.currentChat.value = ChatItem.fromJson(jsonDecode(value));
    });

    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: MoveWindow(
                      child: Obx(() => ChatTitle(title: controller.currentChat.value.name, subtitle: controller.currentChat.value.subtitle.isEmpty ?'Empty Description' : controller.currentChat.value.subtitle, avatar: controller.currentChat.value.avatar)),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          Obx(() => ChatMessage(content: '用Java写个HelloWorld', nicker: settingController.setting.value.profileSetting.nicker, isMe: true, avatar: settingController.setting.value.profileSetting.avatar, time: ''),),
                          Obx(() => ChatMessage(content: """好的
```java
public static void main(String[] args){
  System.out.println("Hello World");

}
```
这是一个用Java写的Hello world。""", nicker: controller.currentChat.value.name, isMe: false, avatar: controller.currentChat.value.avatar, time: ''),),
                          
                        ],
                      ),
                    ),
                  ),
                  ChatInput(),
                ],
              ),
            ),
          ),
          Container(
            width: 240,
            color: const Color.fromARGB(255, 252, 252, 252),
            child: Obx(() => controller.currentChat.value.id == '-' ? Container() : ChatSettings()),
          ),
        ],
      ),
    );
  }


}