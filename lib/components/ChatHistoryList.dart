import 'package:chatgpt_desktop/components/ChatHistoryController.dart';
import 'package:chatgpt_desktop/components/ChatListItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHistoryList extends StatelessWidget{

  ChatHistoryController controller = Get.put(ChatHistoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          return ChatListItem(item: controller.items[index]);
        },
      );
    });
  }

}