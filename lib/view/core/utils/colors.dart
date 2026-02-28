import 'package:flutter/material.dart';

class MyColors {


  static Color primaryBlue(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Color(0xff002DE3)
        : Color(0xff002DE3);
  }


  static Color black(BuildContext context){
    return Theme.of(context).brightness == Brightness.light ?

        Color(0xff0F1828):
        Color(0xffF7F7FC)


    ;
  }

  static Color white(BuildContext context){
    return Theme.of(context).brightness == Brightness.light ?

        Color(0xffF7F7FC) :
        Color(0xffF7F7FC)


    ;
  }


  static Color grey(BuildContext context){


    return  Theme.of(context).brightness == Brightness.light ?

        Color(0xffADB5BD):
        Color(0xffF7F7FC)

    ;

  }


  static Color greyTwo(BuildContext context){

    return Theme.of(context).brightness == Brightness.light ?

    Color(0xffF7F7FC) :
    Color(0xff152033)

    ;


  }


  static Color greyThree(BuildContext context){


    return  Theme.of(context).brightness == Brightness.light ?

        Color(0xffEDEDED):
        Color(0xff152033);



  }

  static Color bgWhite(BuildContext context){

    return Theme.of(context).brightness == Brightness.light?

    Color(0xffFFFFFF):
    Color(0xff0F1828)

    ;

  }


}
