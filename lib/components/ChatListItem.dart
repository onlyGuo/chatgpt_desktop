import 'package:chatgpt_desktop/components/ChatHistoryController.dart';
import 'package:chatgpt_desktop/entity/ChatItem.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:intl/intl.dart";

class ChatListItem extends StatelessWidget{

  final ChatItem item;

  ChatListItem({super.key, required this.item});

  ChatHistoryController controller = Get.put(ChatHistoryController());

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromARGB(255, 176, 155, 206);
    Color selectColor = const Color.fromARGB(255, 146, 113, 182);

    return Listener(
      onPointerDown: (details) {
        if (details.kind == PointerDeviceKind.mouse &&
            details.buttons == kSecondaryMouseButton) {
          _showPopupMenu(context, details.position);
        }
      },
      child: Obx(() => Container(
        decoration: BoxDecoration(
          border: controller.selectedChatId.value == item.id
              ? Border(left: BorderSide(color: selectColor, width: 3))
              : const Border(left: BorderSide(color: Colors.transparent, width: 3)),
          color: controller.selectedChatId.value == item.id
              ? selectColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: MaterialButton(onPressed: () {
          controller.selectChat(item.id);
        }, child: Container(
          padding: const EdgeInsets.all(10),

          child: Row(
            children: [
              if(item.avatar.isNotEmpty)
                CircleAvatar(
                  backgroundImage: NetworkImage(item.avatar),
                )
              else
                CircleAvatar(
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              const SizedBox(width: 6,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),),
                    Text(item.lastMessage.isEmpty ? 'No message' :item.lastMessage, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor, fontSize: 12),),
                  ],
                ),
              ),
              const SizedBox(width: 6,),
              Text(getSimpleLastMessageTime(item.lastMessageTime), style: TextStyle(color: textColor, fontSize: 10)),
            ],
          ),
        ),
        ),
      )),
    );
  }

  void _showPopupMenu(BuildContext context, Offset position) {
    final RenderBox overlay = Overlay.of(context)!.context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        position & Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete,),
              SizedBox(width: 6,),
              Text('Delete', style: TextStyle(fontSize: 12),),
            ],
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value != null) {
        if(value == 'delete'){
          // 删除
          controller.removeChat(item);
        }
      }
    });
  }


  String getSimpleLastMessageTime(String time){
    if(time.isEmpty){
      return '';
    }
    if(time.length < 19) {
      time += ':00';
    }
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final outputFormat = DateFormat('MM/dd');
    final timeFormat = DateFormat('HH:mm');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    final inputDate = inputFormat.parse(time);
    final inputDay = DateTime(inputDate.year, inputDate.month, inputDate.day);

    if (inputDate.isAfter(now.subtract(Duration(minutes: 1)))) {
      return 'Now';
    } else if (inputDate.isAfter(today)) {
      return timeFormat.format(inputDate);
    } else if (inputDay == today) {
      return 'Today';
    } else if (inputDay == yesterday) {
      return 'Yesterday';
    } else {
      return outputFormat.format(inputDate);
    }
  }
}