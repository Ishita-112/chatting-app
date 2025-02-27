import 'package:flutter/material.dart';
import 'package:myapp/themes/dark_mode.dart';
import 'package:myapp/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Initialize with light mode theme
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    // Toggle between light mode and dark mode
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }
}
