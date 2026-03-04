import 'package:e_chat/view/core/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../controllers/signup_controller.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/custom_back_button.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_padding.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {





  final controller = Get.put(SignupController());

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


            CustomText(text: 'Sign up with Email', fontWeight: .w700, fontSize: 24, color: MyColors.black(context)),


            SizedBox(height: 8.h,),


            CustomText(text: 'Welcome back! Sign in using your social account or email to continue us', fontWeight: .w400, fontSize: 14, color: MyColors.black(context),textAlign: .center,),




            SizedBox(height: 60.h,),


            Form(

                key: controller.key.value ,

                autovalidateMode:  controller.mode.value ,

                child: Column(

                  children: [



                    InputField(

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


                    }, autoValidateMode: controller.mode.value , ),


                    SizedBox(height: 38.h,),


                    InputField(

                      controller: controller.passController,

                      hintText: 'Password',validator: (value){


                      if(value == null || value.isEmpty){
                        return  'Enter Password'  ;
                      }

                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }

                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'At least 1 uppercase letter required';
                      }

                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'At least 1 lowercase letter required';
                      }

                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'At least 1 number required';
                      }




                      return null;




                    },autoValidateMode: controller.mode.value,),


                    SizedBox(height: 38.h,),


                    InputField(

                      controller: controller.confirmPassController,

                      hintText: 'Confirm Password',validator: (value){


                      if(value == null || value.isEmpty){
                        return  'Enter Password'  ;
                      }

                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }

                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'At least 1 uppercase letter required';
                      }

                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'At least 1 lowercase letter required';
                      }

                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'At least 1 number required';
                      }




                      return null;




                    },autoValidateMode: controller.mode.value,),


                  ],


                )),



            SizedBox(height: 70.h,),


            Obx(() {

              return CustomButton(

                progress: controller.progress.value,

                text: 'Continue',onTapped: (){

                controller.key.value.currentState!.validate();



                if(controller.passController.text.trim() == controller.confirmPassController.text.trim()){


                  controller.progress.value = true;

                  if( controller.key.value.currentState!.validate() ){//controller.emailController.text.trim().isNotEmpty && controller.passController.text.trim().isNotEmpty && controller.confirmPassController.text.trim().isNotEmpty

                    auth.createUserWithEmailAndPassword(email: controller.emailController.text, password: controller.confirmPassController.text).then((value) {


                      Navigator.pushNamedAndRemoveUntil(context, '/YourProfileScreen', (route) => false,);

                      controller.emailController.clear();
                      controller.passController.clear();
                      controller.confirmPassController.clear();
                      controller.progress.value = false;

                    },).onError((error, stackTrace) {


                      showCustomSnackBar(context, error.toString());
                      controller.progress.value = false;


                    },);


                  }else{
                    controller.progress.value = false;
                  }


                }else{


                  showCustomSnackBar(context, 'Do no match password');
                  controller.progress.value = false;

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
