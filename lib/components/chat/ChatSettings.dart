import 'dart:convert';

import 'package:chatgpt_desktop/components/Avatar.dart';
import 'package:chatgpt_desktop/components/ChatHistoryController.dart';
import 'package:chatgpt_desktop/components/chat/ChatSettingController.dart';
import 'package:chatgpt_desktop/entity/ChatItem.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatSettings extends StatelessWidget {

  // final ChatItem chat;

  ChatSettings({Key? key,}) : super(key: key);

  final ChatSettingController controller = Get.put(ChatSettingController());
  final ChatHistoryController chatHistoryController = Get.put(ChatHistoryController());


  Widget build(BuildContext context) {
    controller.name_controller.text = controller.currentChat.value.name;
    controller.description_controller.text = controller.currentChat.value.subtitle;
    controller.system_controller.text = controller.currentChat.value.system;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Color.fromARGB(255, 246, 246, 246),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Stack(
            children: [
              MaterialButton(
                onPressed: (){
                  Util.pickAndSaveImage().then((value) {
                    controller.currentChat.update((val) {
                      val!.avatar = value;
                    });
                    Util.writeFile('chats/${controller.currentChat.value.id}.json', jsonEncode(controller.currentChat.value));
                    chatHistoryController.updateChatAvatar(controller.currentChat.value.id, value);
                  });
                },
                // 外面禁止点击
                shape: const CircleBorder(),
                child: Avatar(filePath: controller.currentChat.value.avatar, size: 80,),
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),
          Obx(() => Text(
            controller.currentChat.value.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
          Text(
            controller.currentChat.value.subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.1),
          ),

          Expanded(
              child: Container(
                // padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'name',
                        hintText: 'Please enter name',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        suffixIcon: Icon(Icons.person),
                        suffixIconColor: Colors.grey.withOpacity(0.5),
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textInputAction: TextInputAction.done,
                        // 绑定value
                        controller: controller.name_controller,
                        onChanged: (value) {
                          controller.currentChat.update((val) {
                            val!.name = value;
                            chatHistoryController.updateChatName(val.id, value);
                          });
                          Util.writeFile('chats/${controller.currentChat.value.id}.json', jsonEncode(controller.currentChat.value));
                        },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Please enter description',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        suffixIcon: Icon(Icons.description),
                        suffixIconColor: Colors.grey.withOpacity(0.5),
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textInputAction: TextInputAction.done,
                      controller: controller.description_controller,
                      onChanged: (value) {
                        controller.currentChat.update((val) {
                          val!.subtitle = value;
                        });
                        Util.writeFile('chats/${controller.currentChat.value.id}.json', jsonEncode(controller.currentChat.value));
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: (){
                          // 弹出消息Not implemented.
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Please describe system role'),
                                content: Container(
                                  height: 400,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: """Example:
# Role: ChatGPT

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
- Equipped with cross-cultural communication awareness to understand and adapt to diverse cultural contexts in interactions.""",
                                      hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.5),
                                        fontSize: 12,
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    controller: controller.system_controller,
                                    maxLines: 20,
                                    minLines: 10,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      controller.currentChat.value.system = controller.system_controller.text;
                                      Util.writeFile('chats/${controller.currentChat.value.id}.json', jsonEncode(controller.currentChat.value));
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Done'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                  // 左对齐
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'System Role',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      controller.currentChat.value.system.isEmpty ? 'Unset' : 'Already set',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: (){
                        // 弹出消息Not implemented.
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Not implemented.'),
                              content: const Text('This feature is not implemented yet. Please watch for the latest version.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Close'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              child: const Column(
                                // 左对齐
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Plugins',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    'Not implemented.',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10,),
                            child: Column(
                              // 左对齐
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Temperature',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Slider(
                                  value: 0.5,
                                  onChanged: (value) {
                                    print('Input value: $value');
                                  },
                                  min: 0,
                                  max: 1,
                                  divisions: 10,
                                  label: '0.5',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10,),
                            child: Column(
                              // 左对齐
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Dialog round',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Slider(
                                  value: 5,
                                  onChanged: (value) {
                                    print('Input value: $value');
                                  },
                                  min: 1,
                                  max: 30,
                                  divisions: 29,
                                  label: '0.5',

                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
          ),

        ]
      ),
    );
  }
}