import 'package:bitmap/bitmap.dart';
import 'package:chatgpt_desktop/components/ModelController.dart';
import 'package:chatgpt_desktop/entity/Model.dart';
import 'package:chatgpt_desktop/native_interface/NativeScreenshot.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChatInput extends StatelessWidget{
  InputFinish? onFinish;
  ChatInput({this.onFinish});

  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  ModelController modelController = Get.put(ModelController());
  var selectedImage = ''.obs;



  @override
  Widget build(BuildContext context) {
    // controller.addListener(() {
    //   if(controller.text.endsWith('\n')){
    //     if(onFinish != null){
    //       onFinish!(controller.text, 'gpt-3.5-turbo');
    //     }
    //     controller.clear();
    //   }
    // });

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
                IconButton(onPressed: (){}, icon: Icon(Icons.attach_file), tooltip: 'Attach File'),
                IconButton(onPressed: (){
                  Util.pickAndSaveImage().then((value) {
                    selectedImage.value = value;
                  });
                }, icon: Icon(Icons.camera_alt), tooltip: 'Attach Image'),
                IconButton(onPressed: (){
                  // 获取 RenderRepaintBoundary 对象
                  // RenderRepaintBoundary boundary = Global.rootWidgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                  // boundary.toImage(pixelRatio: 3.0).then((value) => {
                  //   value.toByteData(format: ImageByteFormat.png).then((byteData) => {
                  //     Util.saveImageFormByteData(byteData!).then((value) => {
                  //       selectedImage.value = value
                  //     })
                  //   })
                  // });
                  // screenCapturer.requestAccess().then((v)  {
                  //   screenCapturer.capture(
                  //     imagePath: "C:/Users/71934/Desktop/a.png"
                  //   ).then((value) {
                  //     print(value);
                  //     Util.saveImageFormBytes(value!.imageBytes!).then((value) => {
                  //       selectedImage.value = value
                  //     });
                  //   });
                  // });
                  // NativeScreenshot.initialize();
                  // final bytes = NativeScreenshot.captureScreen2();
                  // print(bytes);
                  // Bitmap bitmap = Bitmap.fromHeadless(bytes);
                  // var buildHeaded = bitmap.buildHeaded();
                  // Util.saveImageFormBytes(buildHeaded).then((value) => {
                  //   print(value),
                  //   selectedImage.value = value
                  // });

                  var captureScreen = NativeScreenshot.captureScreen();
                  print(captureScreen.length);
                  Bitmap bitmap = Bitmap.fromHeadless(1024, 768, captureScreen);
                  var buildHeaded = bitmap.buildHeaded();
                  Util.saveImageFormBytes(buildHeaded).then((value) => {
                    print(value),
                    selectedImage.value = value
                  });


                }, icon: Icon(Icons.cut), tooltip: 'Cut'),
                Expanded(child: Container()),
                Obx(() => DropdownButton<Model>(
                  value: modelController.selectModel.value,
                  items: modelController.items
                      .map((Model value) {
                    return DropdownMenuItem<Model>(
                      value: value,
                      child: Text(value.displayName),
                    );
                  }).toList(),
                  underline: Container(),
                  onChanged: (newValue) {
                    modelController.selectModel.value = newValue!;
                    modelController.update();
                  },
                )),

                // IconButton(onPressed: (){}, icon: Row(
                //   children: [
                //     Icon(Icons.model_training),
                //     const SizedBox(width: 5,),
                //     Text('gpt-3.5-turbo')
                //   ],
                // )),
              ],
            ),
          ),
          Expanded(
              child: Container(
                // padding: const EdgeInsets.all(5),
                // color: Colors.red,
                child: RawKeyboardListener(
                  focusNode: focusNode,
                  onKey: handleKeyPress,
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Type a message, press Enter to send, press Shift+Enter to newline.',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    maxLines: 5,
                    controller: controller,
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }

  void handleKeyPress(event) {
    // print(event);
    if (event is RawKeyUpEvent) {
      if (event.logicalKey.keyLabel == "Enter" && !event.isShiftPressed) {
        final val = controller.value;
        final messageWithoutNewLine =
            controller.text.substring(0, val.selection.start - 1) +
                controller.text.substring(val.selection.start);
        controller.value = TextEditingValue(
          text: messageWithoutNewLine,
          selection: TextSelection.fromPosition(
            TextPosition(offset: messageWithoutNewLine.length),
          ),
        );
        String text = controller.text;
        controller.clear();
        if (onFinish != null) {
          onFinish!(text, modelController.selectModel.value.name);
        }
      }
    }
  }
}

typedef InputFinish = void Function(String message, String model);
