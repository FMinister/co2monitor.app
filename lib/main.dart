import 'package:co2app/providers/init_provider.dart';
import 'package:co2app/screens/co2_main_screen.dart';
import 'package:co2app/screens/init_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final AsyncValue<InitState> initProv = ref.watch(initStateProvider);

        return Center(
            child: switch (initProv) {
          AsyncData() =>
            initProv.value.wasInit ? const MainScreen() : const InitScreen(),
          AsyncError() => const Text(
              "ooops",
            ),
          _ => const CircularProgressIndicator(
              strokeWidth: 40,
            ),
        });
      },
    );
  }
}
