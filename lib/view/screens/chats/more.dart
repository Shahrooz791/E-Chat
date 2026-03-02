import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/controllers/more_controller.dart';
import 'package:e_chat/controllers/theme_changer_controller.dart';
import 'package:e_chat/view/core/widgets/custom_button.dart';
import 'package:e_chat/view/core/widgets/custom_snackbar.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/colors.dart';
import '../../core/widgets/custom_padding.dart';
import '../../core/widgets/custom_text.dart';


class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {


  final controller = Get.put(MoreController());

  final id = FirebaseAuth.instance.currentUser!.uid;

  final ref = FirebaseFirestore.instance.collection('userData');

  final themeController = Get.put(ThemeChangerController());



  @override
  Widget build(BuildContext context) {




    return Scaffold(

      backgroundColor: MyColors.bgWhite(context),



      body: SingleChildScrollView(

        child: CustomPadding(child: Column(

          crossAxisAlignment: .start,

          children: [


            SizedBox(height: 47.h,),

            CustomText(text: 'More', fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),


            SizedBox(height: 40.h,),


            Align(
              alignment: .topCenter,
              child: Stack(

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
                    ) :

                    ClipRRect(
                      borderRadius: .circular(60),



                      child: Image.network('https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',fit: .cover,height: 120.h,width: 120.w,),)

                    ,

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
            ),

            SizedBox(height: 30.h,),

            StreamBuilder(


              stream: ref.doc(id).snapshots(),


              builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot) {

                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator()) ;
                }








                return  Column(



                  children: [


                    Align(

                        alignment: .topCenter,

                        child: CustomText(text: snapshot.data!['name'] , fontWeight: .w600, fontSize: 20, color: MyColors.black(context))),


                    SizedBox(height: 25.h,),


                    detail('Bio : ', snapshot.data!['bio']),

                    SizedBox(height: 20.h,),

                    detail('Email : ', snapshot.data!['email']),

                    SizedBox(height: 20.h,),

                    detail('Gender : ', snapshot.data!['gender']),

                    SizedBox(height: 20.h,),


                    detail('Birthday : ', snapshot.data!['dateOfBirth']),

                    SizedBox(height: 20.h,),


                  ],


                ) ;



              },




            ),


            Row(

              mainAxisAlignment: .spaceBetween,

              children: [


                CustomText(text: 'Dark Mode', fontWeight: .w600, fontSize: 16, color: MyColors.black(context)),


                Transform.scale(
                    scale: 0.8,
                    child: Switch(

                      value: themeController.value.value,

                      activeTrackColor: MyColors.primaryBlue(context),
                      activeThumbColor: MyColors.bgWhite(context),

                      inactiveTrackColor: MyColors.greyThree(context),

                      onChanged: (value){

                        themeController.getNewValue(value);

                      },)),


              ],

            ),

            SizedBox(height: 15.h,),


            Row(


              mainAxisAlignment: .spaceBetween,


              children: [

                CustomText(text: 'Languages', fontWeight: .w600, fontSize: 16, color: MyColors.black(context)),


                IconButton(onPressed: (){
                  Navigator.pushNamed(context, '/LanguagesScreen');
                }, icon: Icon(Icons.arrow_forward_ios,color: MyColors.black(context),)),


              ],


            ),


            SizedBox(height: 15.h,),


            StreamBuilder(

              stream: ref.doc(id).snapshots() ,


              builder: (context, snapshot) {



                return  CustomButton(text: 'Edit Profile',onTapped: (){






                  showModalBottomSheet(

                    backgroundColor: MyColors.bgWhite(context),

                    isScrollControlled: true,

                    context: context, builder: (context) {


                    return SingleChildScrollView(

                      child: Padding(
                        padding:  EdgeInsets.only(

                          bottom: MediaQuery.of(context).viewInsets.bottom,

                        ),
                        child: showCustomSheet(snapshot.data!['name'],snapshot.data!['bio'],snapshot.data!['email'],snapshot.data!['dateOfBirth'],snapshot.data!['gender']),
                      ),

                    );

                  },);


                },) ;


              },),


            SizedBox(height: 15.h,),


            Center(child: ElevatedButton(onPressed: (){

              FirebaseAuth.instance.signOut().then((value) {

                Navigator.pushNamedAndRemoveUntil(context, '/LoginScreen', (route) => false,);


              },).onError((error, stackTrace) {

                showCustomSnackBar(context, error.toString());

              },);

            }, child: CustomText(text: 'Logout', fontWeight: .w600, fontSize: 18, color: MyColors.red(context))))


          ],



        )),

      ),



    );




  }




  Widget detail(String name , String userDetail){


    return   Row(


      children: [

        CustomText(text: name, fontWeight: .w600, fontSize: 16, color: MyColors.grey(context)),

        SizedBox(
            width: 200,
            child: CustomText(text: userDetail, fontWeight: .w600, fontSize: 16, color: MyColors.black(context))),


        Spacer(),

        InkWell(

            onTap: (){

              Clipboard.setData(ClipboardData(text: userDetail));
              showCustomSnackBar(context, 'Text copied!');

            },

            child: SvgPicture.asset(SvgImages.copyIcon)),

      ],


    );

    ;

  }




  Widget showCustomSheet(String userName,String bio , String email,String date,String gender){

    if (controller.nameController.text.isEmpty) {
      controller.nameController.text = userName;
      controller.bioController.text = bio;
      controller.emailController.text = email;
      controller.selectDate.value = date;
      controller.selectGender.value = gender;
    }



    return  Container(


      height:  520.h,

      width: .infinity,




      decoration: BoxDecoration(


        color: MyColors.bgWhite(context),

        borderRadius: .circular(20.r),

      ),


      child: SingleChildScrollView(

        child: CustomPadding(child: Column(

          mainAxisSize: .min,

          children: [


            SizedBox(height: 30.h,),

            CustomText(text: 'Edit Profile', fontWeight: .w600, fontSize: 16, color: MyColors.black(context)),

            SizedBox(height: 30.h,),

            Form(

                key: controller.key,
                autovalidateMode:controller.mode.value ,

                child: Column(


                  children: [


                    InputField(controller: controller.nameController,hintText: 'Change Name',
                      validator: (value){

                        if(value == null || value.isEmpty){

                          return  'Enter name';

                        }

                        if(value.length <= 5){

                          return  'Minimum 5 characters' ;

                        }


                        return null;

                      },),

                    SizedBox(height: 15.h,),


                    InputField(controller: controller.bioController,hintText: 'Change Bio',validator: (value){

                      if(value == null || value.isEmpty){

                        return  'Enter name';

                      }

                      if(value.length <= 5){

                        return  'Minimum 5 characters' ;

                      }

                      return null;


                    }),


                    SizedBox(height: 15.h,),


                    InputField(controller: controller.emailController,hintText: 'Change Email',validator: (value){

                      if (value == null || value.isEmpty) {
                        return 'Enter email';
                      }

                      final gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

                      if (!gmailRegex.hasMatch(value)) {
                        return 'Enter valid Gmail address';
                      }

                      return null;

                    },),


                  ],


                )),

            SizedBox(height: 20.h,),


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

            SizedBox(height: 20.h,),


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


            SizedBox(height: 20.h,),

            Obx(() {

              return  CustomButton(progress: controller.progress.value,text: 'Updated',onTapped: ()async{


                controller.key.currentState!.validate();


                if(controller.nameController.text.isNotEmpty && controller.bioController.text.isNotEmpty && controller.emailController.text.isNotEmpty){


                  if(controller.nameController.text.length >= 5 || controller.bioController.text.length >= 5){


                    controller.progress.value = true;

                    await ref.doc(id).update({


                      'name' : controller.nameController.text,
                      'bio' : controller.bioController.text,
                      'email' : controller.emailController.text,
                      'dateOfBirth' : controller.selectDate.value,
                      'gender' : controller.selectGender.value


                    }).then((value) {

                      showCustomSnackBar(context, 'Added Successfully');
                      controller.progress.value = false;
                      Navigator.pop(context);

                    },).onError((error, stackTrace) {


                      showCustomSnackBar(context, error.toString());
                      controller.progress.value = false;

                    },);


                  }else{
                    showCustomSnackBar(context, 'Minimum 5 characters');
                  }


                }





              },);

            },),

            SizedBox(height: 20.h,),


          ],


        )),

      ),


    ) ;

  }



}
