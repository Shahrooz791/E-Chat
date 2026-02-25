import 'package:e_chat/view/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)?  validator;
  final AutovalidateMode?  autoValidateMode;

  const InputField({super.key, required this.hintText, this.controller,this.validator,this.autoValidateMode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,


      validator: validator ,

      autovalidateMode:autoValidateMode ,

      decoration: InputDecoration(
        hintText: hintText.tr(),

        hintStyle: GoogleFonts.saira(
          fontWeight: .w600,

          fontSize: 14.sp,

          color: MyColors.grey(context),
        ),

        focusedBorder: OutlineInputBorder(borderRadius: .circular(4.r),borderSide: .none),

        enabledBorder: OutlineInputBorder(borderRadius: .circular(4.r),borderSide: .none),

        border: OutlineInputBorder(borderRadius: .circular(4.r),borderSide: .none),

        disabledBorder: OutlineInputBorder(borderRadius: .circular(4.r),borderSide: .none),

        errorBorder: OutlineInputBorder(
          borderRadius: .circular(4.r),
          borderSide: BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: .circular(4.r),
          borderSide: BorderSide(color: Colors.red),
        ),

        contentPadding: .zero,

        fillColor: MyColors.white(context),

        filled: true,
      ),
    );
  }
}
