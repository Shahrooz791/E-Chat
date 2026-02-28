import 'package:e_chat/controllers/language_controller.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_back_button.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/widgets/custom_text.dart';


class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {


  final controller = Get.put(LanguageController());



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: MyColors.bgWhite(context),


      body: CustomPadding(child: Column(


        children: [


          SizedBox(height: 47.h,),

          Row(

            crossAxisAlignment: .start,


            children: [

              CustomBackButton(),



              Spacer(flex: 1,),

              CustomText(text: 'Languages', fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),


              Spacer(flex: 2,),


            ],

          ),

          SizedBox(height: 47.h,),

          ListView.separated(

            separatorBuilder: (context, index) => Divider(color: MyColors.greyThree(context),),


            padding: .zero,

            itemCount: controller.languageDetails.length,

            physics: NeverScrollableScrollPhysics(),

            primary: false,

            shrinkWrap: true,


            itemBuilder: (context, index) {


              return ListTile(

                contentPadding: .zero,

                onTap: (){

                  controller.selectIndex.value = index;

                },

                title: CustomText(text: controller.languageDetails[index], fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),

                trailing: InkWell(child: SvgPicture.asset(SvgImages.copyIcon)),

              ) ;

          },



          ),

        ],


      )),


    );



  }



}
