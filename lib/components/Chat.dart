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
                  Expanded(
                    child: Container(
                      color: const Color.fromARGB(255, 252, 252, 252),
                      child: const Center(
                        child: Text('Chat Content'),
                      ),
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 252, 252, 252),
                    height: 180,
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        Container(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.attach_file),),
                              IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)),
                              IconButton(onPressed: (){}, icon: Icon(Icons.cut)),
                              Expanded(child: Container()),
                              IconButton(onPressed: (){}, icon: Row(
                                children: [
                                  Icon(Icons.model_training),
                                  const SizedBox(width: 5,),
                                  Text('gpt-3.5-turbo')
                                ],
                              )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type a message, press Enter to send, press Shift+Enter to newline.',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              maxLines: 5,
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 240,
            color: const Color.fromARGB(255, 252, 252, 252),
            child: ChatSettings(),
          ),
        ],
      ),
    );
  }


}