import 'package:co2app/providers/data_provider.dart';
import 'package:co2app/providers/message_provider.dart';
import 'package:co2app/screens/line_chart_screen.dart';
import 'package:co2app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/color_schemes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MessageProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeProv, _) => Consumer<MessageProvider>(
          builder: (ctx, messageProvider, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "CO2Monitor",
              theme: themeProv.isDark
                  ? ThemeData(useMaterial3: true, colorScheme: lightColorScheme)
                  : ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
              home: const LineChartScreen()),
        ),
      ),
    );
  }
}
