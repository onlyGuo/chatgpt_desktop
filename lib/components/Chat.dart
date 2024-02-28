import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chatgpt_desktop/components/chat/ChatSettings.dart';
import 'package:chatgpt_desktop/components/chat/ChatTitle.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {

  final String id;

  const Chat({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
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
                      child: const ChatTitle(title: 'Chat Title', subtitle: 'subtitle', avatar: ''),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 200,
            color: const Color.fromARGB(255, 252, 252, 252),
            child: ChatSettings(),
          ),
        ],
      ),
    );
  }


}