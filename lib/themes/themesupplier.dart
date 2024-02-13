import 'package:flutter/material.dart';
import 'package:habittracker/themes/darkmode.dart';
import 'package:habittracker/themes/lightmode.dart';

class ThemeSupplier extends ChangeNotifier {
  //ligt mode
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle
  void themeToggle() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
