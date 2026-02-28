

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/chats/chat.dart';
import '../view/screens/chats/contacts.dart';
import '../view/screens/chats/more.dart';

class BottomBarController extends GetxController{

  RxInt  selectIndex = 0.obs;

  RxList  screens = [


    ChatScreen(),
    ContactsScreen(),
    MoreScreen(),

  ].obs;


}