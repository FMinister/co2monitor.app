import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark {
    return _isDark;
  }

  Future<void> setTheme(bool themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = themeMode;
    prefs.setBool("co2DarkMode", themeMode);
    notifyListeners();
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("co2DarkMode")) {
      prefs.setBool("co2DarkMode", _isDark);
    } else {
      _isDark = prefs.getBool("co2DarkMode")!;
    }

    return _isDark;
  }
}
