import 'package:get/get.dart';

import '../models/language_model.dart';

class LanguageController extends GetxController {
  RxInt selectIndex = 0.obs;

  RxList<LanguageModel> languageDetails = <LanguageModel>[
    LanguageModel(languageName: 'English', localeName: 'en'),
    LanguageModel(languageName: 'Arabic', localeName: 'ar'),
    LanguageModel(languageName: 'Danish', localeName: 'da'),
    LanguageModel(languageName: 'Hindi', localeName: 'hi'),
    LanguageModel(languageName: 'Croatian', localeName: 'hr'),
    LanguageModel(languageName: 'Bahasa Indonesia', localeName: 'id'),
    LanguageModel(languageName: 'Filipino', localeName: 'fil'),
    LanguageModel(languageName: 'Urdu', localeName: 'ur'),
    LanguageModel(languageName: 'Chinese', localeName: 'zh'),
  ].obs;
}
