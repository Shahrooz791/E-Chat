import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTapped;

  const CustomButton({super.key, required this.text,this.onTapped});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryBlue(context),
        disabledBackgroundColor: MyColors.primaryBlue(context),
        padding: .zero,
        minimumSize: Size(.infinity, 52.h),
      ),

      onPressed: onTapped,

      child: CustomText(
        text: text.tr(),
        fontWeight: .w600,
        fontSize: 16.sp,
        color: MyColors.white(context),
      ),
    );
  }
}
