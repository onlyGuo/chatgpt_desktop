// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/github.dart';
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
    return HighlightView(
      // The original code to be highlighted
      widget.content,

      // Specify language
      // It is recommended to give it a value for performance
      language: widget.lang,

      // Specify highlight theme
      // All available themes are listed in `themes` folder
      theme: githubTheme,

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
      language = 'javascript';
    }
    return CodeHightLightView(
      content: element.textContent,
      lang: language,
    );
  }
}