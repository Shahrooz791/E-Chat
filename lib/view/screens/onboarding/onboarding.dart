import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_button.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgWhite(context),
      body: CustomPadding(
        child: Column(
          children: [
            SizedBox(height: 135.h),

            Image.asset(PngImages.illustration),

            SizedBox(height: 42.h),

            CustomText(
              text:
                  'Connect easily with your family and friends over countries',
              fontWeight: .w700,
              fontSize: 24,
              color: MyColors.black(context),
              textAlign: .center,
            ),

            SizedBox(height: 126.h),

            CustomText(
              text: 'Terms & Privacy Policy',
              fontWeight: .w600,
              fontSize: 14,
              color: MyColors.black(context),
            ),

            SizedBox(height: 18.h),

            CustomButton(
              text: 'Start Messaging',
              onTapped: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/LoginScreen',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
