import 'dart:ui';

import 'package:craftybay_ecommerce/app/localization/localization_string.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController{
  Locale _currentLocale = LocalizationString.languageEnglish;

  final List<Locale> _supportedLanguages = [
    LocalizationString.languageEnglish, // English
    LocalizationString.languageBengali // Bengali
  ];

  Locale get currentLocale => _currentLocale;
  List<Locale> get supportedLanguages => _supportedLanguages;

  void changeLanguage(Locale locale){
    if(currentLocale == locale){
      return;
    }
    _currentLocale = locale;
    Get.updateLocale(locale); //Getx locale update
    update();
  }
}