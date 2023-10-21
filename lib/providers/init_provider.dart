import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefKeyWasInit = "wasInit";
const String prefKeyApiUrl = "apiUrl";
const String prefKeyApiKey = "apiKey";

final initStateProvider =
    AsyncNotifierProvider.autoDispose<InitStateProvider, InitState>(
  InitStateProvider.new,
);

class InitState {
  InitState({
    this.wasInit = false,
    this.apiUrl = "",
    this.apiKey = "",
  });

  final bool wasInit;
  final String apiUrl;
  final String apiKey;
}

class InitStateProvider extends AutoDisposeAsyncNotifier<InitState> {
  @override
  Future<InitState> build() async {
    return await getInitState();
  }

  Future<InitState> getInitState() async {
    var value = InitState(
      wasInit: false,
      apiUrl: "",
      apiKey: "",
    );
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(prefKeyWasInit)) {
      prefs.setBool(prefKeyWasInit, value.wasInit);
      prefs.setString(prefKeyApiUrl, value.apiUrl);
      prefs.setString(prefKeyApiKey, value.apiKey);
    } else {
      value = InitState(
        wasInit: prefs.getBool(prefKeyWasInit) ?? false,
        apiUrl: prefs.getString(prefKeyApiUrl) ?? "",
        apiKey: prefs.getString(prefKeyApiKey) ?? "",
      );
    }

    return value;
  }

  Future<void> setInitState(bool wasInit, String apiUrl, String apiKey) async {
    var value = InitState(
      wasInit: wasInit,
      apiUrl: apiUrl,
      apiKey: apiKey,
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefKeyWasInit, wasInit);
    prefs.setString(prefKeyApiUrl, apiUrl);
    prefs.setString(prefKeyApiKey, apiKey);

    state = AsyncData(value);
  }

  Future<void> resetInitState() async {
    var value = InitState(
      wasInit: false,
      apiUrl: "",
      apiKey: "",
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(prefKeyWasInit, value.wasInit);
    // prefs.setString(prefKeyApiUrl, value.apiUrl);
    // prefs.setString(prefKeyApiKey, value.apiKey);

    state = AsyncData(value);
  }
}
