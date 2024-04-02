
import 'package:flutter/material.dart';

abstract class GPTPluginInterface {
  Widget get icon;
  /// 插件名称
  String get name;
  /// 插件描述
  String get description;
  /// 插件方法
  List<GPTPluginMethod> get methods;
  /// 执行插件方法
  Future<String> execute(String method, Map<String, dynamic> params,
      String basicUrl, String accessKey);
}

class GPTPluginMethod{
  String name;
  String description;
  List<GPTPluginMethodParameter> parameters;
  GPTPluginMethod(this.name, this.description, this.parameters);

  Map<String, dynamic> parametersMap(){
    Map<String, dynamic> map = {};
    for (var p in parameters) {
      if(p.enums.isNotEmpty){
        map[p.name] = {
          "type": p.type,
          "description": p.description,
          "enums": p.enums,
        };
      }else{
        map[p.name] = {
          "type": p.type,
          "description": p.description,
        };
      }
    }
    List<String> required = [];
    return {
      "type": "object",
      "properties": map,
      "required": required,
    };
  }
  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "description": description,
      "parameters": parametersMap(),
    };
  }
}

class GPTPluginMethodParameter{
  String name;
  String type;
  String description;
  List<String> enums;
  GPTPluginMethodParameter({required this.name, required this.type,
    required this.description, this.enums = const []});
}