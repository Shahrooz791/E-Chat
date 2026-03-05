import 'package:e_chat/controllers/login_controller.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_back_button.dart';
import 'package:e_chat/view/core/widgets/custom_button.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:e_chat/view/core/widgets/custom_snackbar.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(LoginController());
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgWhite(context),

      body: SingleChildScrollView(
        child: CustomPadding(
          child: Column(
            children: [
              SizedBox(height: 47.h),

              Align(alignment: .topLeft, child: CustomBackButton()),

              SizedBox(height: 79.h),

              CustomText(
                text: 'Log in to E-Chat',
                fontWeight: .w700,
                fontSize: 24,
                color: MyColors.black(context),
              ),

              SizedBox(height: 8.h),

              CustomText(
                text:
                    'Welcome back! Sign in using your social account or email to continue us',
                fontWeight: .w400,
                fontSize: 14,
                color: MyColors.black(context),
                textAlign: .center,
              ),

              SizedBox(height: 60.h),

              Form(
                key: controller.key.value,

                autovalidateMode: controller.mode.value,

                child: Column(
                  children: [
                    InputField(
                      controller: controller.emailController,

                      hintText: 'Your email',
                      validator: (value) {
                        // if(value!.isEmpty){
                        //   return   'Enter value';
                        // }else if(!value.contains('@gmail.com')){
                        //   return  'Enter correct email' ;
                        // }

                        if (value == null || value.isEmpty) {
                          return 'Enter email';
                        }

                        final gmailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@gmail\.com$',
                        );

                        if (!gmailRegex.hasMatch(value)) {
                          return 'Enter valid Gmail address';
                        }

                        return null;
                      },
                      autoValidateMode: controller.mode.value,
                    ),

                    SizedBox(height: 38.h),

                    InputField(
                      controller: controller.passController,

                      hintText: 'Your Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        }

                        if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }

                        if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          return 'At least 1 uppercase letter required';
                        }

                        if (!RegExp(r'[a-z]').hasMatch(value)) {
                          return 'At least 1 lowercase letter required';
                        }

                        if (!RegExp(r'[0-9]').hasMatch(value)) {
                          return 'At least 1 number required';
                        }

                        return null;
                      },
                      autoValidateMode: controller.mode.value,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 70.h),

              Obx(() {
                return CustomButton(
                  progress: controller.progress.value,

                  text: 'Continue',
                  onTapped: () async {
                    if (controller.key.value.currentState!.validate()) {
                      controller.progress.value = true;

                      auth
                          .signInWithEmailAndPassword(
                            email: controller.emailController.text.toString(),
                            password: controller.passController.text.toString(),
                          )
                          .then((value) {
                            controller.emailController.clear();
                            controller.passController.clear();
                            controller.progress.value = false;

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/BottomBarScreen',
                              (route) => false,
                            );
                          })
                          .onError((error, stackTrace) {
                            showCustomSnackBar(context, error.toString());
                            controller.progress.value = false;
                          });
                    }
                  },
                );
              }),

              SizedBox(height: 20.h),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/SignupScreen');
                  controller.emailController.clear();
                  controller.passController.clear();
                },
                child: CustomText(
                  text: 'Don’t have an account? Sign Up',
                  fontWeight: .w600,
                  fontSize: 16,
                  color: MyColors.primaryBlue(context),
                ),
              ),

              SizedBox(height: 20.h),

              OutlinedButton(
                onPressed: () {
                  signInWithGoogle()
                      .then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/YourProfileScreen',
                          (route) => false,
                        );
                      })
                      .onError((error, stackTrace) {
                        showCustomSnackBar(context, error.toString());
                      });
                },
                child: Row(
                  mainAxisAlignment: .center,

                  children: [
                    SvgPicture.asset(
                      SvgImages.google,
                      height: 25.h,
                      width: 25.w,
                    ),

                    SizedBox(width: 20.w),

                    CustomText(
                      text: 'SignIn with Google',
                      fontWeight: .w600,
                      fontSize: 20,
                      color: MyColors.black(context),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ForgotScreen');
                  controller.emailController.clear();
                  controller.passController.clear();
                },
                child: CustomText(
                  text: 'Forgot password?',
                  fontWeight: .w600,
                  fontSize: 16,
                  color: MyColors.primaryBlue(context),
                ),
              ),

              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth!.idToken,
      accessToken: googleAuth.accessToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
