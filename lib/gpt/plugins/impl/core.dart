import 'dart:ui';

import 'package:chatgpt_desktop/gpt/plugins/GPTPluginInterface.dart';
import 'package:flutter/material.dart';

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
  String execute(String method, Map<String, dynamic> params) {
    if(method == 'dall_e_draw'){
      return '{url: "https://pica.zhimg.com/70/v2-e87aac6e0564dc8b8d98ab510dd8a77b_1440w.avis?source=172ae18b&biz_tag=Post", remark: "一只小猴子在树上玩耍。"}';
    }
    return '';
  }

  @override
  // TODO: implement icon
  Widget get icon {
    return const Image(image: AssetImage('assets/plugins/draw.png'));
  }

}