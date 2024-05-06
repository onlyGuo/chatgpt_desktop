import 'dart:convert';
import 'dart:ui';

import 'package:chatgpt_desktop/gpt/plugins/GPTPluginInterface.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrawPlugin extends GPTPluginInterface {

  @override
  String get description => 'Draw a picture using DALL·E-3. Not recommended to use the GPT3.5 ';

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
      if(params['size'] != null && !['1024x1024', '1792x1024', '1024x1792'].contains(params['size'])){
        params['size'] = '1024x1024';
      }
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

class BingSearchPlugin extends GPTPluginInterface {

  @override
  String get description => 'Search information on the Internet through Bing';

  @override
  List<GPTPluginMethod> get methods {
    return [
      GPTPluginMethod('search_on_web_for_bing', 'Search information on the Internet through bing.', [
        GPTPluginMethodParameter(
            name: 'keyword',
            type: 'string',
            description: 'Search keywords, up to 30 words long'
        ),
      ]),
    ];
  }

  @override
  String get name => 'Bing Search';

  @override
  Future<String> execute(String method, Map<String, dynamic> params,
      String basicUrl, String accessKey) {
    if(method == 'search_on_web_for_bing'){
      return Future.value('');
    }
    return Future.value('');
  }

  @override
  // TODO: implement icon
  Widget get icon {
    return const Image(image: AssetImage('assets/plugins/draw.png'));
  }

}