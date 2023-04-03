import 'package:co2app/providers/data_provider.dart';
import 'package:co2app/providers/message_provider.dart';
import 'package:co2app/screens/line_chart_screen.dart';
import 'package:co2app/providers/theme_provider.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CO2Monitor",
      // theme: themeProv.isDark
      //     ? ThemeData(useMaterial3: true, colorScheme: lightColorScheme)
      //     : ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const LineChartScreen(),
    );
  }
}
