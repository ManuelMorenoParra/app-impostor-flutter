import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = true; // por defecto oscuro

  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
