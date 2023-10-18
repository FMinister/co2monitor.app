import 'package:co2app/components/color_schemes.dart';
import 'package:co2app/providers/data_provider.dart';
import 'package:co2app/providers/message_provider.dart';
import 'package:co2app/providers/theme_provider.dart';
import 'package:co2app/screens/line_chart_screen.dart';
import 'package:co2app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(themeNotifierProvider);
  }

  void onTabTheme(MyTheme theme) {
    ref.read(themeNotifierProvider.notifier).setTheme(!theme.isDark);
  }

  Future<void> _onTabRefresh(BuildContext context) async {
    final messageProv = ref.read(messageStateNotifierProvider.notifier);
    messageProv.showLoadingSnackBar(context);

    try {
      await ref.read(dataProvider.notifier).getData();
      if (context.mounted) {
        messageProv.showSuccessSnackBar(context, "Data successfully refreshed");
      }
    } catch (err) {
      if (context.mounted) {
        messageProv.showErrorSnackBar(
            context, "Data could not be loaded.\n$err");
      }
    } finally {
      if (context.mounted) {
        messageProv.hideSnackBar(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: MessageStateNotifier.scaffoldKey,
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
      home: Consumer(
        builder: (context, _, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('CO2Monitor'),
              actions: <Widget>[
                IconButton(
                  onPressed: () {
                    _onTabRefresh(context);
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                themeProv.when(
                  data: (theme) => IconButton(
                    onPressed: () {
                      onTabTheme(theme);
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
            drawer: const AppDrawer(),
            body: const LineChartScreen(),
          );
        },
      ),
    );
  }
}
