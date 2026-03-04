import 'package:e_chat/view/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {

  final String message;

  const ChatBubble({super.key,required  this.message});

  @override
  Widget build(BuildContext context) {
    return Container(


      padding: .all(12.r),

      decoration: BoxDecoration(
        
        borderRadius: .circular(12.r),

        color: MyColors.primaryBlue(context),
        
      ),
      
      child: Text(message,style: GoogleFonts.saira(
        fontSize: 16.sp,
        color: MyColors.bgWhite(context),
      ),),


    );
  }
}
