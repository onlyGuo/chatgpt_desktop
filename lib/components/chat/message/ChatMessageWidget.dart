import 'package:chatgpt_desktop/components/Avatar.dart';
import 'package:chatgpt_desktop/components/chat/message/CodeHightLightView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown_selectionarea.dart';


class ChatMessageWidget extends StatelessWidget {
  final String content;
  final String nicker;
  final bool isMe;
  final String avatar;
  final String time;

  ChatMessageWidget({required this.content,
    required this.nicker, required this.isMe,
    required this.avatar, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                // 自适应宽度
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 660,
                ),
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
                // child: SelectableText(
                //   content,
                //   style: const TextStyle(
                //     // color: isMe ? Colors.white : Colors.black,
                //     fontSize: 14,
                //     fontFamily: 'Hiragino Sans',
                //   ),
                // ),
                child: SelectionArea(
                  child: MarkdownBody(
                    data: content,
                    selectable: true,
                    builders: {"code": CodeElementBuilder()},
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

  // MarkdownStyleSheet getMdColorStyle() {
  //   Color defaultRightColor = Colors.white;
  //   Color defaultLeftColor = Colors.black;
  //   if (!Global.loginUser['userProfile']['iosReview'] && isPlus) {
  //     defaultRightColor = const Color.fromARGB(255, 255, 238, 1);
  //     defaultLeftColor = const Color.fromARGB(255, 255, 238, 1);
  //   }
  //   return MarkdownStyleSheet(
  //     code: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     p: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     h1: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     h2: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     h3: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     h4: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     h5: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     h6: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     em: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     strong: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     blockquote: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     img: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     checkbox: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? defaultRightColor
  //           : defaultLeftColor,
  //     ),
  //     blockSpacing: 10,
  //     a: TextStyle(
  //       color: userId == Global.loginUser['id']
  //           ? Colors.blue[100]
  //           : Colors.blue[400],
  //     ),
  //   );
  // }
}