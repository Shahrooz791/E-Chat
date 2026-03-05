import 'package:e_chat/db/theme_changer_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeChangerController extends GetxController {
  RxBool value = false.obs;

  var themeMode = ThemeMode.light.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadTheme();
  }

  void loadTheme() async {
    var data = await ThemeChangerDb.getInstance.getTheme();

    if (data.isNotEmpty) {
      bool isDark = data.first['change'] == 1;

      value.value = isDark;

      themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void getNewValue(bool val) async {
    value.value = val;

    themeMode.value = val ? ThemeMode.dark : ThemeMode.light;

    await ThemeChangerDb.getInstance.setTheme(val);
  }
}
