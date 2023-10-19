import 'package:co2app/components/color_schemes.dart';
import 'package:co2app/providers/init_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Init",
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      home: Consumer(
        builder: (context, _, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Init'),
            ),
            body: Center(
                child: ElevatedButton(
              onPressed: () {
                ref.read(initStateProvider.notifier).setInitState(true, "", "");
              },
              child: const Text('Init'),
            )),
          );
        },
      ),
    );
  }
}
