
import 'package:get/get.dart';

class LanguageController extends GetxController{

  RxList<String> languageDetails = <String>[

    'English',
    'Arabic',
    'Danish',
    'Hindi',
    'Croatian',
    'Bahasa Indonesia',
    'Filipino',
    'Urdu',
    'Chinese',


  ].obs;

  RxInt selectIndex = 0.obs;


}