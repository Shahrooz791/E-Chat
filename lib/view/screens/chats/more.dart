import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/colors.dart';
import '../../core/widgets/custom_padding.dart';
import '../../core/widgets/custom_text.dart';


class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {




  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: MyColors.bgWhite(context),



      body: CustomPadding(child: Column(

        crossAxisAlignment: .start,

        children: [


          SizedBox(height: 47.h,),

          CustomText(text: 'More', fontWeight: .w600, fontSize: 18, color: MyColors.black(context)),




        ],



      )),



    );



  }






}
