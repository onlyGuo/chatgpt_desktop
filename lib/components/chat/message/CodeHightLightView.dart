// ignore_for_file: file_names

import 'package:chatgpt_desktop/components/chat/message/my_flutter_highighter.dart';
import 'package:chatgpt_desktop/gpt/plugins/GPTPluginController.dart';
import 'package:chatgpt_desktop/gpt/plugins/GPTPluginInterface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown_selectionarea.dart';
import 'package:markdown/markdown.dart' as md;

class CodeHightLightView extends StatefulWidget {
  final String content;

  final String lang;

  const CodeHightLightView(
      {super.key, required this.content, required this.lang});

  @override
  State<CodeHightLightView> createState() => _CodeHightLightViewState();
}

class _CodeHightLightViewState extends State<CodeHightLightView> {
  @override
  Widget build(BuildContext context) {
    return MyHighlightView(

      // The original code to be highlighted
      widget.content,

      // Specify language
      // It is recommended to give it a value for performance
      language: widget.lang,

      // Specify highlight theme
      // All available themes are listed in `themes` folder
      theme: atomOneDarkTheme,

      // Specify padding
      padding: const EdgeInsets.all(8),



      // Specify text style
      textStyle: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    var language = '';
    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    } else {
      language = 'plaintext';
    }
    if(element.children != null && element.children?.length == 1 && !element.textContent.contains('\n')) {
      return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
        margin: const EdgeInsets.only(top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(220, 220, 220, 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(element.textContent),
      );
    }
    if(language == 'call-function'){
      String name = element.textContent.contains("!end") ?
      element.textContent.substring(0, element.textContent.indexOf("!end")) : element.textContent;
      GPTPluginInterface plugin = GPTPluginController.getByFunctionName(name.replaceAll("\n", ""));
      return Container(
        color: Colors.white,
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(220, 220, 220, 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: plugin.icon,
                        ),
                        const SizedBox(width: 5,),
                        Text(plugin.name),
                      ],
                    ),
                    if(element.textContent.contains("!end"))
                      const Row(
                        children: [
                          Icon(Icons.check, color: Colors.green, size: 12,),
                          Text('Completed!', style: TextStyle(fontSize: 12, color: Colors.grey),),
                        ],
                      )
                    else
                      const Row(
                        children: [
                          Icon(Icons.timer, color: Colors.blue, size: 12,),
                          Text('Running...', style: TextStyle(fontSize: 12, color: Colors.grey),),
                        ],
                      )
                  ],
                ),
            ),
            Expanded(child: Container())
          ],
        ),
      );

    }
    return CodeHightLightView(
      content: element.textContent.endsWith('\n') ? element.textContent.substring(0, element.textContent.length - 1) : element.textContent,
      lang: language,
    );
  }
}