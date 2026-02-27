

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController{

  RxInt  selectIndex = 0.obs;

  RxList  screens = [


    Scaffold(

      body: Center(child: Text('message'),),

    ),

    Scaffold(

      body: Center(child: Text('contacts'),),

    ),


    Scaffold(

      body: Center(child: Text('more'),),

    ),

  ].obs;


}