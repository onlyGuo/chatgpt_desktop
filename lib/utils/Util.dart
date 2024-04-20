import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chatgpt_desktop/entity/ChatMessage.dart';
import 'package:chatgpt_desktop/gpt/plugins/GPTPluginInterface.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


class Util{

  static String getMd5(String text){
    return md5.convert(utf8.encode(text)).toString();
  }
  static Future<String> copyImageToAppDir() async {
    final directory = await getApplicationCacheDirectory();

    // 假设您的图片文件位于assets文件夹中
    ByteData data = await rootBundle.load('assets/chatgpt.png');
    List<int> bytes = data.buffer.asUint8List();
    File imageFile = File('${directory.path}/default-avatar.png');
    await imageFile.writeAsBytes(bytes);

    return imageFile.path;
  }

  static Future<String> saveImageFormUrl(String url) async {
    final directory = await getApplicationCacheDirectory();
    File imageFile = File('${directory.path}/cache/${getMd5(url)}');
    if(imageFile.existsSync() && imageFile.lengthSync() != 0){
      return imageFile.path;
    }else{
      imageFile.createSync(recursive: true);
    }
    Uri uri = Uri.parse(url);
    var request = http.Request('GET', uri);
    http.Client client = http.Client();
    return client.send(request).then((response) {
      return response.stream.toBytes().then((value) {
        return imageFile.writeAsBytes(value).then((value) {
            return imageFile.path;
        });
      });
    });
  }

  static Future<String> pickAndSaveImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final directory = await getApplicationCacheDirectory();
      final File imageFile = File('${directory.path}/select-images/${pickedFile.name}');
      if(imageFile.existsSync() == false){
        imageFile.createSync(recursive: true);
      }
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
    await imageFile.writeAsString(content);
  }

  static Future<String> readFile(String filename) async {
    final directory = await getApplicationCacheDirectory();
    final File file = File('${directory.path}/files/$filename');
    if(file.existsSync() == false){
      return '';
    }
    return file.readAsString();
  }

  static void postStream(String url, Map<String, String> header, Map<String, dynamic> body, Function callback) async {
    Uri uri = Uri.parse(url);
    var request = http.Request('POST', uri);

    request.body = jsonEncode(body);

    Map<String, String> headers = {"Content-type": "application/json"};
    headers.addAll(header);
    http.Client client = http.Client();
    client.head(uri, headers: headers);
    client.send(request).then((response) {
      response.stream.listen((List<int> data) {
        callback(data);
        print(data);
      });
    });
  }

  static Future<String> post(String url, Map<String, String> header, Map<String, dynamic> body) async {
    Uri uri = Uri.parse(url);
    var request = http.Request('POST', uri);

    request.body = jsonEncode(body);

    Map<String, String> headers = {
      // "Content-type": "application/json"
    };
    headers.addAll(header);
    request.headers.addAll(headers);
    http.Client client = http.Client();
    return client.send(request).then((response) {
      return response.stream.bytesToString();
    });
  }


  static void askGPT(String basicUrl, String model, double temperature,
      String accessKey, List<GPTPluginInterface> plugin, List<ChatMessage> message,
      GPTCallbackFunction callback, Function err, {bufferContent = ''}) async {
    print(jsonEncode(message));
    final messages = [];
    for (var m in message) {
      if(m.toolsCallId.isNotEmpty){
        messages.add({
          "role": m.role,
          "content": m.content,
          "tool_call_id": m.toolsCallId
        });
      }else{
        if(m.toolCalls != null){
          messages.add({
            "role": m.role,
            "content": m.content,
            "tool_calls": [m.toolCalls?.toMap()]
          });
        }else{
          messages.add({
            "role": m.role,
            "content": m.content,
          });
        }
      }

    }
    List<dynamic> tools = [];
    final requestBody = {
      "model": model,
      "messages": messages,
      "temperature": temperature,
      "stream": true,
    };

    // 添加插件
    for (var p in plugin) {
      for(var method in p.methods){
        tools.add({
          "type": "function",
          "function": method.toMap(),
        });
      }
    }
    if(tools.isNotEmpty){
      requestBody["tools"] = tools;
    }
    basicUrl = basicUrl.endsWith('/') ? basicUrl : '$basicUrl/';
    var request = http.Request("POST", Uri.parse('${basicUrl}v1/chat/completions'));
    request.headers["Authorization"] = "Bearer $accessKey";
    request.headers["Content-Type"] = "application/json; charset=UTF-8";
    request.body = jsonEncode(requestBody);

    // 开始请求
    http.Client().send(request).then((response) {
      String showContent = bufferContent;
      String callFunctionId = "";
      String callFunction = "";
      String callFunctionParams = "";

      final stream = response.stream.transform(utf8.decoder);
      // 监听接收的数据
      stream.listen((data) {
        if(response.statusCode != 200){
          String finalData = data;
          if(!finalData.endsWith("```")){
            if(finalData.contains('<html>')) {
              finalData = "\n```html\n$finalData\n```";
            } else {
              finalData = "\n```json\n$finalData\n```";
            }
          }
          showContent += "Request failed: ${response.statusCode}\n$finalData";
          callback(showContent, false);
          return;
        }
        final dataLines = data.split("\n").where((element) => element.isNotEmpty).toList();
        for (String line in dataLines) {
          // 丢弃前6个字符：“data: ”
          if (!line.startsWith("data: ")) continue;
          final data = line.substring(6);

          if (data == "[DONE]") break; // 表示接收已完成

          // 解析数据
          Map<String, dynamic> responseData = json.decode(data);
          List<dynamic> choices = responseData["choices"];
          Map<String, dynamic> choice = choices[0];
          Map<String, dynamic> delta = choice["delta"];
          String content = delta["content"] ?? "";
          if (delta["tool_calls"] != null && delta["tool_calls"].isNotEmpty) {
            // 插件调用
            var tool = delta["tool_calls"][0];
            if(tool["function"] != null){
              if(tool["function"]["name"] != null){
                callFunction = tool["function"]["name"];
                callFunctionId = tool["id"];
                showContent += "\n\n```call-function\n$callFunction";
              }
              callFunctionParams += tool["function"]["arguments"];
            }
          }

          // 拼接并展示数据
          showContent += content;
          callback(showContent, false);
          if (choice["finish_reason"] != null) break; // 表示接收已完成
        }
      },
        onDone: ()  {
          if(callFunction.isNotEmpty){
            // 执行插件方法
            for (var p in plugin) {
              for(var method in p.methods){
                if(method.name == callFunction){
                  message.add(ChatMessage(
                      content: "", role: 'assistant', time: '',
                      toolCalls: ToolCalls(
                          id: callFunctionId, type: 'function',
                          function: ToolCallsFunction(
                              name: method.name, arguments: callFunctionParams
                          )
                      )
                  ));
                  Map<String, dynamic> functionParam = jsonDecode(callFunctionParams);
                  p.execute(method.name, functionParam, basicUrl, accessKey).then((value) {
                    message.add(ChatMessage(content: value, role: 'tool', time: '', toolsCallId: callFunctionId));
                    showContent += '!end\n```\n';
                    askGPT(basicUrl, model, temperature, accessKey, plugin, message, callback, err,
                        bufferContent: showContent);
                  });
                  return;
                }
              }
            }
          }else{
            callback(showContent, true);
          }
        },
        onError: (error) => err(error),
      );
    });
  }
}
typedef GPTCallbackFunction = void Function(String result, bool finish);