import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class Util{
  static Future<String> copyImageToAppDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    // 假设您的图片文件位于assets文件夹中
    ByteData data = await rootBundle.load('assets/chatgpt.png');
    List<int> bytes = data.buffer.asUint8List();
    File imageFile = File('$appDocPath/default-avatar.png');
    await imageFile.writeAsBytes(bytes);

    return imageFile.path;
  }

  static Future<String> pickAndSaveImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationCacheDirectory();
      final File imageFile = File('${directory.path}/select-images/${pickedFile.path.split('/').last}');
      await imageFile.writeAsBytes(await pickedFile.readAsBytes());
      return imageFile.path;
    }
    return '';
  }

  static void writeFile(String filename, String content) async {

    final directory = await getApplicationCacheDirectory();
    final File imageFile = File('${directory.path}/files/$filename');
    if(imageFile.existsSync() == false){
      imageFile.createSync(recursive: true);
    }
    await imageFile.writeAsBytes(content.codeUnits);
  }

  static Future<String> readFile(String filename) async {
    final directory = await getApplicationCacheDirectory();
    final File file = File('${directory.path}/files/$filename');
    if(file.existsSync() == false){
      return '';
    }
    return file.readAsString();
  }
}