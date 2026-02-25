import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLine;

  const CustomText({
    super.key,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.color,
    this.textAlign,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr(),

      textAlign: textAlign,

      maxLines: maxLine,

      style: GoogleFonts.saira(
        color: color,

        fontWeight: fontWeight,

        fontSize: fontSize.sp,
      ),
    );
  }
}
