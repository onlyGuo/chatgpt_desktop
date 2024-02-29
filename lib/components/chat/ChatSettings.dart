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
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Avatar(filePath: '', size: 80,),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Chat Title',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Subtitle',
            style: TextStyle(
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

                                    maxLines: 20,
                                    minLines: 10,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    onChanged: (text) {
                                      // Handle the text input here
                                      print('Input text: $text');
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
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
                                child: const Column(
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
                                      'Unset',
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