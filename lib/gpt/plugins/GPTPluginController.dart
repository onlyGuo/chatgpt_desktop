import 'package:chatgpt_desktop/gpt/plugins/GPTPluginInterface.dart';
import 'package:chatgpt_desktop/gpt/plugins/impl/core.dart';

class GPTPluginController {
  static List<GPTPluginInterface> plugins = [
    DrawPlugin()
  ];

  static GPTPluginInterface getByFunctionName(String name) {
    for (var plugin in plugins) {
      for (var method in plugin.methods) {
        if (method.name == name) {
          return plugin;
        }
      }
    }
    throw Exception('Plugin not found');
  }
}