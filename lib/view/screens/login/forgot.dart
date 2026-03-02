import 'package:e_chat/view/core/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../controllers/forgot_pass_controller.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_padding.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/input_field.dart';


class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {





  final controller = Get.put(ForgotPassController());

  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: MyColors.bgWhite(context),



      body: SingleChildScrollView(


        child: CustomPadding(child: Column(


          children: [



            SizedBox(height: 47.h,),

            Align(
                alignment: .topLeft,
                child: CustomBackButton()),


            SizedBox(height: 79.h,),


            CustomText(text: 'Forgot password', fontWeight: .w700, fontSize: 24, color: MyColors.black(context)),


            SizedBox(height: 8.h,),


            CustomText(text: 'Recover your account password', fontWeight: .w400, fontSize: 14, color: MyColors.black(context),textAlign: .center,),




            SizedBox(height: 60.h,),


            Form(

                key: controller.key.value ,

                autovalidateMode:  controller.mode.value ,

                child: InputField(

                  controller: controller.emailController,

                  hintText: 'Your email',validator: (value) {


                  // if(value!.isEmpty){
                  //   return   'Enter value';
                  // }else if(!value.contains('@gmail.com')){
                  //   return  'Enter correct email' ;
                  // }

                  if (value == null || value.isEmpty) {
                    return 'Enter email';
                  }

                  final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

                  if (!gmailRegex.hasMatch(value)) {
                    return 'Enter valid Gmail address';
                  }

                  return null;


                }, autoValidateMode: controller.mode.value , )),



            SizedBox(height: 70.h,),


            Obx(() {

              return  CustomButton(

                progress: controller.progress.value,

                text: 'Continue',onTapped: (){

                controller.key.value.currentState!.validate();


                if(controller.emailController.text.isNotEmpty){

                  controller.progress.value = true;

                  auth.sendPasswordResetEmail(email: controller.emailController.text).then((value) {

                    showCustomSnackBar(context, 'Password forgot link share in your email');
                    controller.emailController.clear();
                    controller.progress.value = false;

                  },).onError((error, stackTrace) {

                    showCustomSnackBar(context, error.toString());
                    controller.progress.value = false;


                  },);

                }





              },) ;


            },) ,


            SizedBox(height: 20.h,),




          ],


        )),


      ),


    );



  }







}
