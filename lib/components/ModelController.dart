import 'dart:convert';

import 'package:chatgpt_desktop/entity/Model.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:get/get.dart';

class ModelController extends GetxController{

  RxList<Model> items = RxList<Model>([]);
  Rx<Model> selectModel = Model(displayName: 'GPT-3.5', name: 'gpt-3.5-turbo').obs;

  void addModel(displayName, name) => {
    items.add(Model(displayName: displayName, name: name)),
    Util.writeFile('models.json', jsonEncode(items)),
    update()
  };

  void removeModel(Model model) => {
    items.remove(model),
    Util.writeFile('models.json', jsonEncode(items)),
    update()
  };

  @override
  void onReady() {
    // 从本地存储中获取
    try {
      Util.readFile('models.json').then((value) {
        if(value.isEmpty){
          value = jsonEncode([
            Model(displayName: 'GPT-3.5', name: 'gpt-3.5-turbo'),
            Model(displayName: 'GPT-4', name: 'gpt-4-turbo'),
          ]);
          Util.writeFile('models.json', value);
        }
        jsonDecode(value).map<Model>((item) => Model.fromJson(item)).toList().forEach((element) {
          items.add(element);
        });
        selectModel.value = items[0];
        update();  // 通知 Flutter 刷新 UI
      });
    } catch (e) {
      items.add(Model(displayName: 'GPT-3.5', name: 'gpt-3.5-turbo'),);
      items.add(Model(displayName: 'GPT-4', name: 'gpt-4-turbo'),);
      selectModel.value = items[0];
      Util.writeFile('models.json', jsonEncode(items));
    }
    super.onReady();
  }


  void updateChatName(int index, String displayName, String name){
    items[index].displayName = displayName;
    items[index].name = name;
    items.refresh();
    Util.writeFile('models.json', jsonEncode(items));
    update();
  }
}

