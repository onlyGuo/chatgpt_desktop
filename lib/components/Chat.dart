import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chatgpt_desktop/components/chat/ChatInput.dart';
import 'package:chatgpt_desktop/components/chat/ChatSettingController.dart';
import 'package:chatgpt_desktop/components/chat/ChatSettings.dart';
import 'package:chatgpt_desktop/components/chat/ChatTitle.dart';
import 'package:chatgpt_desktop/components/chat/message/ChatMessageWidget.dart';
import 'package:chatgpt_desktop/controller/SettingController.dart';
import 'package:chatgpt_desktop/entity/ChatItem.dart';
import 'package:chatgpt_desktop/entity/ChatMessage.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {

  final String id;

  Chat({super.key, required this.id});

  ChatSettingController controller = Get.put(ChatSettingController());
  SettingController settingController = Get.put(SettingController());
  ScrollController _scrollController = ScrollController();

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
                      child: Obx(() => ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: controller.currentChat.value.history.length,
                        itemBuilder: (context, index) {
                          var history = controller.currentChat.value.history;
                          return buildChatMessage(history[history.length - index - 1]);
                        },
                      ))
                    ),
                  ),
                  ChatInput(onFinish: (input, model){
                    if(input.isEmpty){
                      return;
                    }
                    controller.currentChat.value.history.add(ChatMessage(content: input, role: 'user', time: ''));
                    // 只保留最后50条消息
                    if(controller.currentChat.value.history.length > 50){
                      controller.currentChat.value.history =
                          controller.currentChat.value.history
                              .sublist(controller.currentChat.value.history.length - 50);
                    }
                    Util.writeFile('chats/${controller.currentChat.value.id}.json', jsonEncode(controller.currentChat.value));
                    controller.currentChat.refresh();

                    // build request message
                    int dialogCount = controller.currentChat.value.dialogCount;
                    int allLength = controller.currentChat.value.history.length;
                    List<ChatMessage> reqMsg = allLength > dialogCount ?
                    controller.currentChat.value.history.sublist(allLength - dialogCount) :
                    controller.currentChat.value.history;
                    if(controller.currentChat.value.system.isNotEmpty){
                      // 在最前面加上系统消息
                      reqMsg.insert(0, ChatMessage(content: controller.currentChat.value.system, role: 'system', time: ''));
                    }else{
                      // 在最前面加上问候语
                      reqMsg.insert(0, ChatMessage(content: """# Role: ChatGPT
## Model Version: $model              
## Goals
- Provide insightful and accurate responses to a broad range of user inquiries.
- Engage in meaningful and contextually relevant dialogue with users.
- Continuously learn from interactions to enhance the quality of responses.
- Identify underlying patterns in user needs and proactively offer solutions and advice.
- If the user's question includes Chinese, please answer in Chinese.

## Constraints
- Must not engage in political discussions or generate content related to such topics.
- Must avoid any discussion or content that involves or relates to child exploitation.

## Skills
- Deep understanding and generation of natural language text.
- Ability to maintain conversation across a multitude of topics.
- Proficiency in synthesizing information from various sources into coherent answers.
- Skilled in providing thoughtful and personalized recommendations.
- Trained to recognize and accommodate the nuances of human communication styles.
- Equipped with cross-cultural communication awareness to understand and adapt to diverse cultural contexts in interactions.""", role: 'system', time: ''));
                    }

                    // 请求GPT
                    ChatMessage replyChatMessage = ChatMessage(content: '', role: 'assistant', time: '');
                    controller.currentChat.update((val) {
                      controller.currentChat.value.history.add(replyChatMessage);
                    });
                    Util.askGPT(settingController.setting.value.apiSetting.baseUrl,
                        model, controller.currentChat.value.temperature,
                        settingController.setting.value.apiSetting.accessToken, reqMsg, (result, finish) {
                          controller.currentChat.update((val) {
                            replyChatMessage.content = result;
                          });
                          if(finish){
                            Util.writeFile('chats/${controller.currentChat.value.id}.json', jsonEncode(controller.currentChat.value));
                          }
                        }, (err){
                      print(err);
                        });
                  },),
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

  Widget buildChatMessage(ChatMessage message) {
    return ChatMessageWidget(
        content: message.content,
        nicker: message.role == 'user' ? settingController.setting.value.profileSetting.nicker : controller.currentChat.value.name,
        isMe: message.role == 'user',
        avatar: message.role == 'user' ? settingController.setting.value.profileSetting.avatar : controller.currentChat.value.avatar, time: '');
  }


}