import 'dart:async';

import 'package:co2app/providers/theme_provider.dart';
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
    // Do not set _isLoading to false here
    Provider.of<DataProvider>(context, listen: false)
        .fetchLatestData()
        .then((_) => Provider.of<DataProvider>(context, listen: false)
                .fetchAndSetData()
                .then((_) {
              setState(() {
                _isLoading = false;
              });
            }))
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

  void onTabTheme() {
    Provider.of<ThemeProvider>(context, listen: false).setTheme(!_themeIsDark);
    setState(() {
      _themeIsDark = !_themeIsDark;
    });
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: onTabTheme,
              child: Icon(
                _themeIsDark ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
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
                Co2LineChartWidget(dataProvider.data, 6),
                Co2LineChartWidget(dataProvider.data, 6)
              ],
            ),
    );
  }
}
