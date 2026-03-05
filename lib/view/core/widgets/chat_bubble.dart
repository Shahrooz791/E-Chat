import 'package:e_chat/view/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12.r),

      margin: .symmetric(vertical: 5.h),

      decoration: BoxDecoration(
        borderRadius: .circular(12.r),

        color: MyColors.primaryBlue(context),
      ),

      child: Column(
        children: [
          Text(
            message,
            style: GoogleFonts.saira(
              fontSize: 16.sp,
              color: MyColors.bgWhite(context),
            ),
          ),
        ],
      ),
    );
  }
}
