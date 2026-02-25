import 'package:e_chat/view/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: .zero,
      alignment: .topLeft,
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        color: MyColors.black(context),
        size: 24.sp,
      ),
    );
  }
}
