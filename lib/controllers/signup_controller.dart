
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{



  var key = GlobalKey<FormState>().obs;


  final Rx<AutovalidateMode> mode = AutovalidateMode.disabled.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();


}