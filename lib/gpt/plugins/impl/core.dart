import 'dart:convert';
import 'dart:ui';

import 'package:chatgpt_desktop/gpt/plugins/GPTPluginInterface.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrawPlugin extends GPTPluginInterface {

  @override
  String get description => 'Draw a picture using DALL·E-3. return the image path and remark.';

  @override
  List<GPTPluginMethod> get methods {
    return [
      GPTPluginMethod('dall_e_draw', 'Draw a picture and return the URL and description of the picture. You need to use ![img](url) to display the picture.', [
        GPTPluginMethodParameter(
            name: 'prompt',
            type: 'string',
            description: 'A text description of the desired image(s). The maximum length is 4000 characters'
        ),
        GPTPluginMethodParameter(
            name: 'size',
            type: 'string',
            description: 'The size of the image, default value: 1024x1024',
            enums: ['1024x1024', '1792x1024', '1024x1792']),
      ]),
    ];
  }

  @override
  String get name => 'DALL·E-3';

  @override
  Future<String> execute(String method, Map<String, dynamic> params,
      String basicUrl, String accessKey) {
    if(method == 'dall_e_draw'){
      basicUrl = basicUrl.endsWith('/') ? basicUrl : '$basicUrl/';
      try{
        return Util.post('${basicUrl}v1/images/generations', {
          "Authorization": "Bearer $accessKey",
          "Content-Type": "application/json; charset=UTF-8"
        }, {
          "model": "dall-e-3",
          "prompt": params['prompt'],
          "n": 1,
          "size": params['size'] ?? '1024x1024',
          "quality": "standard",
          "response_format": "url",
          "style": "vivid"
        });
      }catch(e) {
        print(e.toString());
        return Future.value('');
      }
    }
    return Future.value('');
  }

  @override
  // TODO: implement icon
  Widget get icon {
    return const Image(image: AssetImage('assets/plugins/draw.png'));
  }

}