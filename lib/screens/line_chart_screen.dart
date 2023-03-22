import 'package:co2app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/static_lines.dart';
import '../providers/data_provider.dart';
import '../widgets/line_chart.dart';

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
    setState(() {
      _isLoading = true;
    });
    Provider.of<DataProvider>(context, listen: false)
        .fetchAndSetData()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      Center(
        child: Text("An error occurred, data could not be loaded. \n$error"),
      );
    });
    _isLoading = false;
    super.initState();
  }

  void onTabTheme() {
    Provider.of<ThemeProvider>(context, listen: false).setTheme(!_themeIsDark);
    setState(() {
      _themeIsDark = !_themeIsDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            "CO2Monitor",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : LineChartWidget(pricePoints),
    );
  }
}
