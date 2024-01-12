import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
  String appLang = 'en';
  ThemeData appTheme = ThemeData.light();

  void changeLanguage(String lang) {
    appLang = lang;
    notifyListeners();
  }

  void changeTheme(ThemeData them) {
    appTheme = them;
    notifyListeners();
  }
}
