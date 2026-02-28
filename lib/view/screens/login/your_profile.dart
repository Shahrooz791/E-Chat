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
import 'package:easy_localization/easy_localization.dart';
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


            InputField(


              controller: controller.nameController,

              hintText: 'Enter Name',




            ),


            SizedBox(height: 38.h,),


            InputField(


                controller: controller.bioController,


                hintText: 'Add Bio'),

            SizedBox(height: 38.h,),

            Obx(() => Container(

              height: 45.h,

              width: .infinity,

              decoration: BoxDecoration(

                borderRadius: .circular(4.r),

                color: MyColors.greyTwo(context),

              ),

              child: Row(


                children: [


                  SizedBox(width: 10.h,),



                  CustomText(text: controller.selectDate.value, fontWeight: .w500, fontSize: 14, color: controller.selectDate.value !=  'Select Date'?  MyColors.black(context) : MyColors.grey(context)),

                  Spacer(),

                  IconButton(onPressed: ()async{




                    var datePicked   =   await showDatePicker(

                      barrierColor: MyColors.bgWhite(context),

                      context: context,

                      firstDate: DateTime(1947),

                      lastDate: DateTime.now(),

                      initialDate: DateTime.now(),

                    );


                    if(datePicked != null){
                      controller.selectDate.value = '${datePicked.day}/${datePicked.month}/${datePicked.year}';
                    }



                  }, icon: Icon(Icons.calendar_month,color: MyColors.grey(context),)),


                ],


              ),

            ),),



            SizedBox(height: 38.h,),


            Obx(() => Container(

              height: 45.h,

              width: .infinity,

              decoration: BoxDecoration(

                borderRadius: .circular(4.r),

                color: MyColors.greyTwo(context),

              ),

              child: Row(


                children: [


                  SizedBox(width: 10.h,),



                  CustomText(text: controller.selectGender.value, fontWeight: .w500, fontSize: 14, color:controller.selectGender.value != 'Select Gender' ? MyColors.black(context) : MyColors.grey(context)),

                  Spacer(),




                  DropdownButton(

                    value: null,



                    icon: Icon(Icons.arrow_drop_down,
                        color: MyColors.grey(context)),


                    underline: SizedBox(),

                    dropdownColor: MyColors.bgWhite(context),

                    items: [

                      DropdownMenuItem(value: 'Male',child: CustomText(text: 'Male', fontWeight: .w600, fontSize: 16, color: MyColors.black(context))),
                      DropdownMenuItem(value: 'Female',child: CustomText(text: 'Female', fontWeight: .w600, fontSize: 16, color: MyColors.black(context))),

                    ],

                    onChanged: (value) {
                      controller.selectGender.value = value!;
                    },
                  ),

                  SizedBox(width: 10.h,),



                ],


              ),

            ),),


            SizedBox(height: 50.h,),


            Obx(() {

              return CustomButton(

                progress: controller.progress.value,

                text: 'Save',



                onTapped: (){


                  final id = FirebaseAuth.instance.currentUser!.uid;



                  if(controller.nameController.text.isNotEmpty && controller.bioController.text.isNotEmpty  && controller.image.value != null && controller.selectDate.value != 'Select Date' && controller.selectGender.value != 'Select Gender' ){


                    controller.progress.value = true;

                    if(controller.nameController.text.length <= 5){
                      controller.progress.value = false;
                      return showCustomSnackBar(context, 'Minimum 5 characters of Name') ;
                    }

                    if(controller.bioController.text.length <= 5 ){
                      controller.progress.value = false;
                      return showCustomSnackBar(context, 'Minimum 5 characters of Bio') ;
                    }




                    ref.doc(id).set({
                      'id' : id,
                      'name' : controller.nameController.text,
                      'bio' : controller.bioController.text,
                      'email' : FirebaseAuth.instance.currentUser!.email,
                      'dateOfBirth' : controller.selectDate.value,
                      'gender' : controller.selectGender.value
                    }).then((value) {


                      controller.nameController.clear();
                      controller.bioController.clear();
                      Navigator.pushNamedAndRemoveUntil(context, '/BottomBarScreen', (route) => false,);

                      controller.progress.value = false;

                    },).onError((error, stackTrace) {

                      showCustomSnackBar(context, error.toString());
                      controller.progress.value = false;



                    },);





                  }else{


                    showCustomSnackBar(context, 'Please complete all fields');
                    controller.progress.value = false;

                  }





                },



              ) ;


            },),





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