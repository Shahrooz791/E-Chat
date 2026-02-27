import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/controllers/your_profile_controller.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_button.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:e_chat/view/core/widgets/custom_snackbar.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../core/widgets/custom_back_button.dart';


class YourProfileScreen extends StatefulWidget {
  const YourProfileScreen({super.key});

  @override
  State<YourProfileScreen> createState() => _YourProfileScreenState();
}

class _YourProfileScreenState extends State<YourProfileScreen> {



  final controller = Get.put(YourProfileController());



  final  ref = FirebaseFirestore.instance.collection('userData');

  @override
  Widget build(BuildContext context) {


    return Scaffold(




      backgroundColor: MyColors.bgWhite(context),
      
      
      body: SingleChildScrollView(


        child: CustomPadding(

            child: Column(


          children: [


            SizedBox(height: 47.h,),

            CustomText(text: 'Your Profile', fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),




            SizedBox(height: 50.h,),

            Stack(

              children: [


                Obx(() => CircleAvatar(

                  radius: 60.r,


                  backgroundColor: MyColors.greyTwo(context),


                  child: controller.image.value != null ?ClipRRect(
                    borderRadius: BorderRadius.circular(60.r),
                    child: Image.file(
                      controller.image.value!,
                      width: 120.r,
                      height: 120.r,
                      fit: BoxFit.cover,
                    ),
                  ) :  SvgPicture.asset(SvgImages.profileIcon , height: 44.h,width: 37.w,color: MyColors.black(context), ),

                ),),



                Positioned(

                  right: 3,
                  bottom: 10,

                  child: InkWell(

                      onTap: (){
                        controller.getImage();
                      },

                      child: SvgPicture.asset(SvgImages.addImageIcon,height:   24.h,width: 24.w,)),
                ),

              ],


            ),


            SizedBox(height: 50.h,),


            Form(

                key: controller.key,

                autovalidateMode: controller.mode.value,

                child: Column(



                  children: [


                    InputField(


                      controller: controller.firstNameController,

                      hintText: 'First Name (Required)',

                      validator: (value){


                        if(value == null || value.isEmpty){


                          return 'Enter value' ;

                        }else if( value.length < 5){
                          return 'Minimum 5 letter';
                        }



                      },



                    ),


                    SizedBox(height: 38.h,),


                    InputField(


                        controller: controller.lastNameController,

                        validator: (value){


                          if(value == null || value.isEmpty){


                            return 'Enter value' ;

                          }else if( value.length < 5){
                            return 'Minimum 5 letter';
                          }



                        },

                        hintText: 'Last Name (Optional)'),


                  ],


                )),


            SizedBox(height: 50.h,),


            CustomButton(text: 'Save',



              onTapped: (){



                controller.key.currentState!.validate();

                controller.mode.value = AutovalidateMode.always;


                if(controller.firstNameController.text.isNotEmpty && controller.lastNameController.text.isNotEmpty && controller.firstNameController.text.length >= 5 && controller.lastNameController.text.length >= 5 && controller.image.value != null ){



                  ref.doc('id').set({
                    'firstName' : controller.firstNameController.text,
                    'lastName' : controller.lastNameController.text,
                  }).then((value) {


                    controller.firstNameController.clear();
                    controller.lastNameController.clear();
                    Navigator.pushNamedAndRemoveUntil(context, '/BottomBarScreen', (route) => false,);


                  },).onError((error, stackTrace) {

                    showCustomSnackBar(context, error.toString());



                  },);





                }





              },


               /*
                onTapped: () async {

                  controller.mode.value = AutovalidateMode.always;
                  print('check ${FirebaseAuth.instance.currentUser?.uid}');

                  final id = FirebaseAuth.instance.currentUser!.uid;

                  if (controller.key.currentState!.validate() &&
                      controller.image.value != null) {

                    try {

                      await ref.doc(id).set({
                        'firstName': controller.firstNameController.text,
                        'lastName': controller.lastNameController.text,
                      });

                      showCustomSnackBar(context, 'Added Successfully');

                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   '/BottomBarScreen',
                      //   (route) => false,
                      // );

                    } catch (e) {
                      showCustomSnackBar(context, e.toString());
                      debugPrint('error $e');
                    }

                  } else {
                    showCustomSnackBar(context, 'Please complete all fields');
                  }
                }
                */


            ),





          ],


        )),


      ),



    );


  }





}


/*
            Row(


              crossAxisAlignment: .start,

              children: [

                CustomBackButton(),

                Spacer(flex: 1,),


                CustomText(text: 'Your Profile', fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),

                Spacer(flex: 2,),

              ],


            ),
             */