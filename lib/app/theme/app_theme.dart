
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme{
  static ThemeData get lightTheme => ThemeData(
      colorSchemeSeed: AppColors.themeColor,
    inputDecorationTheme: _inputDecoration,
    filledButtonTheme: _filledButton,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF00BFA5),
      unselectedItemColor: Color(0xFF9E9E9E),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),




  );
  static ThemeData get darkTheme => ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      brightness: Brightness.dark,
    inputDecorationTheme: _inputDecoration,
    filledButtonTheme: _filledButton,
    textTheme: _textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF121212),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFF00B8A9),
      unselectedItemColor: Color(0xFFB0B0B0),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 12),
    ),

  );


static InputDecorationThemeData get _inputDecoration => InputDecorationThemeData(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.themeColor)
      ),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.themeColor)
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.themeColor)
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      hintStyle: TextStyle(color: Colors.grey[400])
);

static FilledButtonThemeData get _filledButton => FilledButtonThemeData(
  style: FilledButton.styleFrom(
      fixedSize: Size.fromWidth(double.maxFinite),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: AppColors.themeColor
  ),

);
static TextTheme get _textTheme => TextTheme(
  displayLarge:TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  displaySmall:TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
  displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)

  ) ;

}
