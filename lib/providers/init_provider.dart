import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final initProvider = FutureProvider.autoDispose((ref) async {
  return await InitProvider().getInit();
});

class InitProvider {
  InitProvider({
    this.wasInit = false,
    this.apiUrl = "",
    this.apiKey = "",
  });

  final bool wasInit;
  final String apiUrl;
  final String apiKey;

  Future<InitProvider> getInit() async {
    var init = InitProvider(
      wasInit: false,
      apiUrl: "",
      apiKey: "",
    );
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("wasInit")) {
      prefs.setBool("wasInit", init.wasInit);
      prefs.setString("apiUrl", "");
      prefs.setString("apiKey", "");
    } else {
      init = InitProvider(
        wasInit: prefs.getBool("wasInit") ?? false,
        apiUrl: prefs.getString("apiUrl") ?? "",
        apiKey: prefs.getString("apiKey") ?? "",
      );
    }

    return init;
  }
}
