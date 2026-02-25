import 'package:e_chat/view/core/utils/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  RxList<String>  authImages = <String>[
    SvgImages.facebook,
    SvgImages.google,
    SvgImages.apple,
  ].obs;


  var key = GlobalKey<FormState>().obs;


  final Rx<AutovalidateMode> mode = AutovalidateMode.disabled.obs;

  final emailController = TextEditingController();
  final passController = TextEditingController();

}