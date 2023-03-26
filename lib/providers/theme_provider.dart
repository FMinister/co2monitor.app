import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;
  final String prefKey = "co2DarkMode";

  ThemeProvider() {
    getTheme();
  }

  get isDark {
    return _isDark;
  }

  Future<void> setTheme(bool themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = themeMode;
    prefs.setBool(prefKey, themeMode);
    notifyListeners();
  }

  Future<void> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(prefKey)) {
      prefs.setBool(prefKey, _isDark);
    } else {
      _isDark = prefs.getBool(prefKey)!;
    }
    notifyListeners();
  }
}
