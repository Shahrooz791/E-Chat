
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class YourProfileController extends GetxController{


  var key = GlobalKey<FormState>();

  final Rx<AutovalidateMode>  mode = AutovalidateMode.disabled.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();









  Rx<File?> image = Rx<File?>(null);

  void getImage()async{

    final imagePicker  = await ImagePicker().pickImage(source: .gallery);

    if(imagePicker != null){

      image.value = File(imagePicker.path);

    }


  }









  @override
  void onClose() {
    // TODO: implement onClose

    firstNameController.dispose();
    lastNameController.dispose();

    super.onClose();
  }

}