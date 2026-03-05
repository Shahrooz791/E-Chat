import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MoreController extends GetxController {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();

  RxBool progress = false.obs;

  RxString selectGender = ''.obs;
  RxString selectDate = ''.obs;

  var key = GlobalKey<FormState>();

  Rx<AutovalidateMode> mode = AutovalidateMode.disabled.obs;

  Rx<File?> image = Rx<File?>(null);

  void getImage() async {
    final imagePicker = await ImagePicker().pickImage(source: .gallery);

    if (imagePicker != null) {
      image.value = File(imagePicker.path);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    nameController.dispose();
    bioController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
