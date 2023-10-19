import 'package:co2app/helpers/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final setInitStateProvider =
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
    return InitState(
      wasInit: false,
      apiUrl: "",
      apiKey: "",
    );
  }

  Future<InitState> getInitState() async {
    var value = InitState(
      wasInit: false,
      apiUrl: "",
      apiKey: "",
    );
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("wasInit")) {
      prefs.setBool("wasInit", value.wasInit);
      prefs.setString("apiUrl", value.apiUrl);
      prefs.setString("apiKey", value.apiKey);
    } else {
      value = InitState(
        wasInit: prefs.getBool("wasInit") ?? false,
        apiUrl: prefs.getString("apiUrl") ?? "",
        apiKey: prefs.getString("apiKey") ?? "",
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
    prefs.setBool("wasInit", wasInit);
    prefs.setString("apiUrl", apiUrl);
    prefs.setString("apiKey", apiKey);

    state = AsyncData(value);
  }

  Future<void> resetInitState() async {
    var value = InitState(
      wasInit: false,
      apiUrl: "",
      apiKey: "",
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("wasInit", value.wasInit);
    prefs.setString("apiUrl", value.apiUrl);
    prefs.setString("apiKey", value.apiKey);

    state = AsyncData(value);
  }
}
