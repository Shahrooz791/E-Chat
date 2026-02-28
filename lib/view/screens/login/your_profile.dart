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


                      controller: controller.nameController,

                      hintText: 'Enter Name',

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


                        controller: controller.bioController,

                        validator: (value){


                          if(value == null || value.isEmpty){


                            return 'Enter value' ;

                          }else if( value.length < 5){
                            return 'Minimum 5 letter';
                          }



                        },

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



                          CustomText(text: controller.selectDate.value, fontWeight: .w600, fontSize: 14, color: MyColors.grey(context)),

                          Spacer(),

                          IconButton(onPressed: ()async{




                            var datePicked   =   await showDatePicker(

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



                          CustomText(text: controller.selectGender.value, fontWeight: .w600, fontSize: 14, color: MyColors.grey(context)),

                          Spacer(),

                          //IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down,color: MyColors.grey(context),)),

                          DropdownButton(

                              icon: Icon(Icons.arrow_drop_down,color: MyColors.grey(context),),


                              value: controller.selectGender,

                              items: [

                                DropdownMenuItem(value: 'Male',child: CustomText(text: 'Male', fontWeight: .w600, fontSize: 16, color: MyColors.black(context)),onTap: (){
                                  controller.selectGender.value = 'Male';
                                },),
                                DropdownMenuItem(value: 'Female',child: CustomText(text: 'Female', fontWeight: .w600, fontSize: 16, color: MyColors.black(context)),onTap: (){
                                  controller.selectGender.value = 'Female';
                                },),

                              ], onChanged: (value){}),

                          DropdownButton<String>(

                            value: controller.selectGender.value == 'Select Gender'
                                ? null
                                : controller.selectGender.value,

                            hint: CustomText(
                                text: 'Select Gender',
                                fontWeight: .w600,
                                fontSize: 14,
                                color: MyColors.grey(context)),

                            icon: Icon(Icons.arrow_drop_down,
                                color: MyColors.grey(context)),

                            underline: SizedBox(),

                            items: ['Male', 'Female']
                                .map((gender) => DropdownMenuItem<String>(
                              value: gender,
                              child: CustomText(
                                  text: gender,
                                  fontWeight: .w600,
                                  fontSize: 16,
                                  color: MyColors.black(context)),
                            ))
                                .toList(),

                            onChanged: (value) {
                              controller.selectGender.value = value!;
                            },
                          ),


                        ],


                      ),

                    ),),



                  ],


                )),


            SizedBox(height: 50.h,),


            Obx(() {

              return CustomButton(

                progress: controller.progress.value,

                text: 'Save',



                onTapped: (){



                  controller.key.currentState!.validate();

                  controller.mode.value = AutovalidateMode.always;

                  final id = FirebaseAuth.instance.currentUser!.uid;


                  if(controller.nameController.text.isNotEmpty && controller.bioController.text.isNotEmpty && controller.nameController.text.length >= 5 && controller.bioController.text.length >= 5 && controller.image.value != null ){


                    controller.progress.value = true;

                    ref.doc(id).set({
                      'id' : id,
                      'name' : controller.nameController.text,
                      'bio' : controller.bioController.text,
                      'email' : FirebaseAuth.instance.currentUser!.email,
                    }).then((value) {


                      controller.nameController.clear();
                      controller.bioController.clear();
                      Navigator.pushNamedAndRemoveUntil(context, '/BottomBarScreen', (route) => false,);

                      controller.progress.value = false;

                    },).onError((error, stackTrace) {

                      showCustomSnackBar(context, error.toString());
                      controller.progress.value = false;



                    },);





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