import 'package:flutter/material.dart';
import 'package:todo/shared/style/colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: mintGreen,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

      )
  );
  static ThemeData dartTheme = ThemeData();
}
