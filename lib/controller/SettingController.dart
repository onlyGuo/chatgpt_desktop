import 'dart:convert';

import 'package:chatgpt_desktop/entity/ApiSetting.dart';
import 'package:chatgpt_desktop/entity/ProfileSetting.dart';
import 'package:chatgpt_desktop/entity/Setting.dart';
import 'package:chatgpt_desktop/utils/Util.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  Rx<Setting> setting = Setting(profileSetting: ProfileSetting(), apiSetting: ApiSetting()).obs;
  @override
  void onInit() {
    super.onInit();
    Util.readFile('settings.json').then((value) {
      if (value.isEmpty) {
        value = jsonEncode(Setting(profileSetting: ProfileSetting(), apiSetting: ApiSetting()));
        Util.writeFile('settings.json', value);
      }
      setting.value = Setting.fromJson(jsonDecode(value));
    });
  }
}