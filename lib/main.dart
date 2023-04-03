import 'package:co2app/providers/theme_provider.dart';
import 'package:co2app/screens/line_chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/color_schemes.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  void onTabTheme(MyTheme theme, WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).setTheme(!theme.isDark);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeProv = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CO2Monitor",
      theme: themeProv.when(
        data: (theme) => theme.isDark
            ? ThemeData(useMaterial3: true, colorScheme: darkColorScheme)
            : ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        error: (err, _) =>
            ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        loading: () =>
            ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CO2Monitor'),
          actions: <Widget>[
            themeProv.when(
              data: (theme) => IconButton(
                onPressed: () {
                  onTabTheme(theme, ref);
                },
                icon: theme.isDark
                    ? Icon(
                        Icons.light_mode,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).colorScheme.primary,
                      ),
              ),
              error: (err, _) => Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.primary,
              ),
              loading: () => CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: const LineChartScreen(),
      ),
    );
  }
}
