

import 'package:flutter/cupertino.dart';

import '../../screens/login/forgot.dart';
import '../../screens/login/login.dart';
import '../../screens/login/signup.dart';
import '../../screens/login/your_profile.dart';
import '../../screens/onboarding/onboarding.dart';
import 'bottom_bar.dart';

class MyRoutes{


  static Map<String , Widget Function (BuildContext)> routes = {

    '/' : (context) => Onboarding(),
    '/Onboarding' : (context) => Onboarding(),
    '/LoginScreen' : (context) => LoginScreen(),
    '/SignupScreen' : (context) => SignupScreen(),
    '/YourProfileScreen' : (context) => YourProfileScreen(),
    '/ForgotScreen' : (context) => ForgotScreen(),
    '/BottomBarScreen' : (context) => BottomBarScreen(),


};


}