import 'dart:async';

import 'package:co2app/providers/message_provider.dart';
import 'package:co2app/providers/theme_provider.dart';
import 'package:co2app/widgets/app_drawer.dart';
import 'package:co2app/widgets/temp_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/data_provider.dart';
import '../widgets/co2_line_chart.dart';

class LineChartScreen extends StatefulWidget {
  const LineChartScreen({super.key});

  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  var _isLoading = true;
  bool _themeIsDark = false;

  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false)
        .getTheme()
        .then((_) => _themeIsDark =
            Provider.of<ThemeProvider>(context, listen: false).isDark)
        .then((value) => Provider.of<DataProvider>(context, listen: false)
            .fetchLatestData()
            .then((_) => Provider.of<DataProvider>(context, listen: false)
                    .fetchAndSetData()
                    .then((_) {
                  setState(() {
                    _isLoading = false;
                  });
                })))
        .catchError((error) {
      Center(
        child: Text("An error occurred, data could not be loaded. \n$error"),
      );
    });
    fetchLatestDataEveryMinute();
  }

  Future<void> fetchLatestDataEveryMinute() async {
    Timer.periodic(const Duration(seconds: 60), (_) async {
      await Provider.of<DataProvider>(context, listen: false)
          .fetchLatestDataEveryMinute();
    });
  }

  void _onTabTheme() {
    Provider.of<ThemeProvider>(context, listen: false).setTheme(!_themeIsDark);
    setState(() {
      _themeIsDark = !_themeIsDark;
    });
  }

  Future<void> _onTabRefresh(BuildContext context) async {
    Provider.of<MessageProvider>(context, listen: false).hideSnackBar(context);
    try {
      Provider.of<MessageProvider>(context, listen: false)
          .showLoadingSnackBar(context);
      Future.wait([
        Provider.of<DataProvider>(context, listen: false).fetchLatestData(),
        Provider.of<DataProvider>(context, listen: false).fetchAndSetData(),
      ]);
      if (context.mounted) {
        Provider.of<MessageProvider>(context, listen: false)
            .showSuccessSnackBar(context, "Data successfully refreshed!");
      }
    } catch (error) {
      Provider.of<MessageProvider>(context, listen: false)
          .showErrorSnackBar(context, error.toString());
    } finally {
      Provider.of<MessageProvider>(context, listen: false)
          .hideSnackBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "CO2Monitor",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
          size: 30,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () async => await _onTabRefresh(context),
                    child: Icon(
                      Icons.refresh,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: _onTabTheme,
                    child: Icon(
                      _themeIsDark ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
        automaticallyImplyLeading: true,
      ),
      drawer: const AppDrawer(),
      body: dataProvider.data.isEmpty
          ? _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : const Center(
                  child: Text('No data found.'),
                )
          : ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    "${DateFormat("yyyy.MM.dd - HH:mm").format(dataProvider.latestData.date)}, CO2: ${dataProvider.latestData.co2}, Temp: ${dataProvider.latestData.temp}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Co2LineChartWidget(dataProvider.data),
                Divider(
                  color: Theme.of(context).colorScheme.outline,
                ),
                TempLineChartWidget(dataProvider.data),
              ],
            ),
    );
  }
}
