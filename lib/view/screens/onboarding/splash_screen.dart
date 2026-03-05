import 'dart:async';

import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;

  void checkLogin() {
    var user = _auth.currentUser;

    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/BottomBarScreen',
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/Onboarding',
        (route) => false,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgWhite(context),

      body: CustomPadding(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,

          children: [
            Center(
              child: Image.asset(
                PngImages.appLogo,
                height: 170.h,
                width: 170.w,
              ),
            ),

            SizedBox(height: 20.h),

            CustomText(
              text: 'E-Chat',
              fontWeight: .bold,
              fontSize: 45.sp,
              color: MyColors.appLogoColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
