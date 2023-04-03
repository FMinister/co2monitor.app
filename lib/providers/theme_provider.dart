import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "theme_provider.g.dart";
part "theme_provider.freezed.dart";

const String prefKey = "co2DarkMode";

@freezed
class MyTheme with _$MyTheme {
  factory MyTheme({
    required bool isDark,
  }) = _MyTheme;
}

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<MyTheme> build() async {
    return await getTheme();
  }

  Future<MyTheme> getTheme() async {
    state = const AsyncValue.loading();
    var themeMode = MyTheme(isDark: false);
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(prefKey)) {
      prefs.setBool(prefKey, themeMode.isDark);
    } else {
      themeMode = MyTheme(isDark: prefs.getBool(prefKey)!);
    }

    state = AsyncValue.data(themeMode);

    return themeMode;
  }

  Future<void> setTheme(bool themeMode) async {
    state = const AsyncValue.loading();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefKey, themeMode);
    state = AsyncValue.data(MyTheme(isDark: themeMode));
  }
}
