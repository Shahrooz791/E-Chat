import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';



class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {




  @override
  Widget build(BuildContext context) {



    return Scaffold(


      backgroundColor: MyColors.bgWhite(context),



      body: CustomPadding(child: Column(


        crossAxisAlignment: .start,


        children: [



          SizedBox(height: 47.h,),
          
          
          
          CustomText(text: 'Chats', fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),



          SizedBox(height: 20.h,),
          
          
          InputField(hintText: 'Search',prefixIcon: Column(

            mainAxisAlignment: .center,

            children: [

              SvgPicture.asset(SvgImages.searchIcon,height: 24.h,width: 24.w,),

            ],

          ),),



          


        ],



      )),


    );




  }





}
