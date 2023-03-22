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
    prefs.setBool("darkMode", themeMode);
    notifyListeners();
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("darkMode")) {
      prefs.setBool("darkMode", _isDark);
    } else {
      _isDark = prefs.getBool("darkMode")!;
    }

    return _isDark;
  }
}
