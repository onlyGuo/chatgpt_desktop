import 'package:chatgpt_desktop/components/Avatar.dart';
import 'package:flutter/material.dart';

class ChatSettings extends StatelessWidget {

  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Color.fromARGB(255, 246, 246, 246),
            width: 1,
          ),
        ),
      ),
      child: const Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Avatar(filePath: '', size: 80,),
          SizedBox(
            height: 10,
          ),
          Text(
            'Chat Title',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Subtitle',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ]
      ),
    );
  }
}