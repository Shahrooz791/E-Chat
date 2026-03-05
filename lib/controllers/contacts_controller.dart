import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  final searchController = TextEditingController();
  RxString searchText = ''.obs;
  @override
  void onClose() {
    // TODO: implement onClose
    searchController.dispose();
    super.onClose();
  }
}
