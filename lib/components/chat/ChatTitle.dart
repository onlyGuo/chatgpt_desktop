import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chatgpt_desktop/components/Avatar.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String avatar;

  const ChatTitle({super.key, required this.title, required this.subtitle, required this.avatar});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Avatar(filePath: avatar, size: 50),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}