
import 'dart:io';

import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown_selectionarea.dart';
import 'package:get/get.dart';
import 'package:markdown/markdown.dart' as md;

class ImageElementBuilder extends MarkdownElementBuilder {

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // if (element.attributes['src'] != null) {
    //   return Image.network(element.attributes['src'] as String);
    // }
    // return null;
    String src = element.attributes['src'].toString();
    // 先判断是否是HTTP，如果是HTTP则将图片保存到本地，用本地路径加载
    if (src.startsWith("http")) {
      return FutureBuilder(future: Util.saveImageFormUrl(src), builder: (BuildContext content,
          AsyncSnapshot<String> snapshot) {
        if(snapshot.hasData){
          return Image.file(File(snapshot.data.toString()));
        }
        return const CircularProgressIndicator();
      });

    }
    return Container(
      child: Text("![img](${element.attributes['src']})"),
    );
  }
}