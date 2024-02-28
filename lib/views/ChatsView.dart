import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsView extends StatelessWidget {

  var inputValue = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MoveWindow(
          child: Container(
            width: 220,
            color: const Color.fromARGB(255, 85, 43, 129),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 79, 0, 143),
                      )
                    )
                  ),
                  child:  Container(
                    padding: const EdgeInsets.all(10),
                    child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            // 海拔
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 64, 29, 102),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextField(
                              maxLines: 1,
                              minLines: 1,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                // 上下边距
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                hintText: 'Search your chats',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 110, 90, 122)
                                ),
                                prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 110, 90, 122)), // 添加图标
                                prefixIconConstraints: BoxConstraints.tightFor(width: 30, height: 20), // 设置图标大小
                              ),
                              style: const TextStyle(
                                fontSize: 12, // 设置文字字号
                                fontFamily: 'Roboto;Arial;Helvetica;Georgia;微软雅黑',
                                color: Color.fromARGB(255, 161, 161, 161)
                              ),
                              onChanged: (value) {
                                inputValue.value = value;
                              },
                            ),
                          ) 
                        ),
                        SizedBox(width: 10,),
                        // 原型按钮
                        IconButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 64, 29, 102)), // 设置背景颜色与输入框的文字颜色一致
                          ),
                          icon: Icon(Icons.add),
                          color: Color.fromARGB(255, 110, 90, 122),
                          hoverColor: Color.fromARGB(255, 53, 23, 85),
                          padding: EdgeInsets.all(0),
                          iconSize: 20,
                          constraints: BoxConstraints.tightFor(width: 30, height: 30),
                        ),
                      ],
                    )
                  ),
                ),
              )],
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}