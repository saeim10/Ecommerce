import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void changeTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    Get.changeThemeMode(_themeMode);

    update();
  }
}