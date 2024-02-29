import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

}