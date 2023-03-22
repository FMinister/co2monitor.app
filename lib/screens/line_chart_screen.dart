import 'package:flutter/material.dart';

import '../components/static_lines.dart';
import '../widgets/line_chart.dart';

class LineChartScreen extends StatefulWidget {
  const LineChartScreen({super.key, required this.title});
  final String title;

  @override
  State<LineChartScreen> createState() => _LineChartScreenState();
}

class _LineChartScreenState extends State<LineChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CO2Monitor")),
      body: content(),
    );
  }

  Widget content() {
    return LineChartWidget(pricePoints);
  }
}
