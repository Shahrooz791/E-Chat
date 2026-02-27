
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController{

  var key = GlobalKey<FormState>().obs;

  final Rx<AutovalidateMode> mode = AutovalidateMode.disabled.obs;

  final emailController = TextEditingController();




  @override
  void onClose() {
    // TODO: implement onClose
    emailController.dispose();
    super.onClose();
  }

}