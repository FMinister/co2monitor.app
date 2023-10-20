import 'package:co2app/components/color_schemes.dart';
import 'package:co2app/providers/init_provider.dart';
import 'package:co2app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  final _formKey = GlobalKey<FormState>();
  var _apiKey = "";
  var _apiUrl = "";

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    ref.read(initStateProvider.notifier).setInitState(true, _apiUrl, _apiKey);
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(children: [
                  const SizedBox(height: 50),
                  Icon(
                    Icons.cloud_sync_sharp,
                    size: 150,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Please enter your API URL and key",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'API URL',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.cloud_queue),
                    ),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'API key',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.cloud_queue),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Init",
    //   theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
    //   home: Consumer(
    //     builder: (context, _, __) {
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: const Text('Init'),
    //         ),
    //         body: Center(
    //             child: ElevatedButton(
    //           onPressed: () {
    //             ref.read(initStateProvider.notifier).setInitState(true, "", "");
    //           },
    //           child: const Text('Init'),
    //         )),
    //       );
    //     },
    //   ),
    // );
  }
}
