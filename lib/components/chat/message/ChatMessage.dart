import 'package:chatgpt_desktop/components/Avatar.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String content;
  final String nicker;
  final bool isMe;
  final String avatar;
  final String time;

  ChatMessage({required this.content,
    required this.nicker, required this.isMe,
    required this.avatar, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment:CrossAxisAlignment.start,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isMe)
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: Avatar(filePath: avatar, size: 40),
            ),
          Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(nicker, style: Theme.of(context).textTheme.labelSmall),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: isMe ? Colors.green : Colors.white,
                  // 海拔
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: SelectableText(
                  content,
                  style: const TextStyle(
                    // color: isMe ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontFamily: 'Hiragino Sans',
                  ),
                ),
              ),
            ],
          ),
          if (isMe)
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Avatar(filePath: avatar, size: 40),
            ),
        ],
      ),
    );
  }
}