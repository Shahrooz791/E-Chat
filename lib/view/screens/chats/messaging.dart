import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_back_button.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../controllers/messaging_controller.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final controller = Get.put(MessagingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyThree(context),

      appBar: AppBar(
        title: CustomText(
          text: 'userName'.toString(),
          fontWeight: .w600,
          fontSize: 18,
          color: MyColors.black(context),
        ),

        centerTitle: true,

        leading: Align(alignment: .bottomRight, child: CustomBackButton()),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),

        child: Container(
          height: 90.h,

          width: .infinity,

          color: MyColors.bgWhite(context),

          child: Row(
            mainAxisAlignment: .spaceBetween,

            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: MyColors.grey(context)),
              ),

              SizedBox(
                width: 260,
                child: InputField(
                  controller: controller.messageController,
                  hintText: 'Enter Message',
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  SvgImages.sendIcon,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
