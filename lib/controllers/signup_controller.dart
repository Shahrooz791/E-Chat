import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  var key = GlobalKey<FormState>().obs;

  final Rx<AutovalidateMode> mode = AutovalidateMode.disabled.obs;

  RxBool progress = false.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void onClose() {
    // TODO: implement onClose
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }
}
