import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chatgpt_desktop/components/Chat.dart';
import 'package:chatgpt_desktop/components/ChatHistoryController.dart';
import 'package:chatgpt_desktop/components/ChatHistoryList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsView extends StatelessWidget {
  var inputValue = ''.obs;

  Color textColor = const Color.fromARGB(255, 115, 98, 140);

  Color bgDarkColor = const Color.fromARGB(255, 54, 37, 79);

  Color bgColor = const Color.fromARGB(150, 64, 46, 88);

  ChatHistoryController chatHistoryController = Get.put(ChatHistoryController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 240,
          color: bgColor,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 1,
                  color: bgDarkColor,
                ))),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: bgDarkColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            maxLines: 1,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // 上下边距
                              isDense: true,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Search your chats',
                              hintStyle: TextStyle(color: textColor),
                              prefixIcon: Icon(Icons.search, color: textColor),
                              // 添加图标
                              prefixIconConstraints:
                              const BoxConstraints.tightFor(
                                  width: 30, height: 20), // 设置图标大小
                            ),
                            style: TextStyle(
                                fontSize: 12, // 设置文字字号
                                fontFamily:
                                'Roboto;Arial;Helvetica;Georgia;微软雅黑',
                                color: textColor),
                            onChanged: (value) {
                              inputValue.value = value;
                            },
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        // 原型按钮
                        IconButton(
                          onPressed: () {
                            chatHistoryController.addChat();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                bgDarkColor), // 设置背景颜色与输入框的文字颜色一致
                          ),
                          icon: const Icon(Icons.add),
                          color: textColor,
                          hoverColor: Color.fromARGB(255, 53, 23, 85),
                          padding: EdgeInsets.all(0),
                          iconSize: 20,
                          constraints:
                              BoxConstraints.tightFor(width: 30, height: 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: ChatHistoryList()),
            ],
          ),
        ),
        Expanded(child: Container(
          color: Colors.transparent,
          child: Obx(() => Chat(id: chatHistoryController.selectedChatId.value)),
        ))
      ],
    );
  }
}
