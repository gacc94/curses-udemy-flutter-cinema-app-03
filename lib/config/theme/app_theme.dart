import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF2862F5);

class AppTheme with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      notifyListeners();
    }
  }

  AppTheme() {
    isDarkMode = false;
  }

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: primaryColor,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );
  }
}
