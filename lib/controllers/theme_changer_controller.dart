
import 'package:e_chat/db/theme_changer_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeChangerController extends GetxController {


  RxBool value = false.obs;

  var themeMode = ThemeMode.light.obs;


  void getNewValue(bool val)async{

    value.value = val;

    themeMode.value = val ? ThemeMode.dark : ThemeMode.light;

    await ThemeChangerDb.getInstance.setTheme(val);

  }



}