import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'custom_text.dart';


void showCustomSnackBar(BuildContext context,String message){

  ScaffoldMessenger.of(context).showSnackBar(



    SnackBar(


      content: CustomText(text: message, fontWeight: .w600, fontSize: 12, color: MyColors.white(context)) ,



      backgroundColor: MyColors.black(context),

      shape: RoundedRectangleBorder(
        borderRadius: .circular(12.r),
      ),

      behavior: .floating,

      margin: .all(16),


      duration: Duration(seconds: 2),


      showCloseIcon: true,

    ),




  );


}