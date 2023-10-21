import 'dart:math';

import 'package:co2app/providers/data_provider.dart';
import 'package:co2app/providers/period_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../helpers/interval_helper.dart';

class Co2LineChartWidget extends ConsumerWidget {
  final List<Co2Data> points;
  final IntervallHelper intervalHelper = IntervallHelper();

  Co2LineChartWidget(this.points, {Key? key}) : super(key: key);

  Widget _bottomTitleWidget(double value, TitleMeta meta) {
    var text = DateFormat("HH:mm").format(points[value.toInt()].date);
    if (value.toInt() > points.length - 3) {
      text = "";
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  int _getInterval(dynamic context, int period) {
    return intervalHelper.calculateInterval(context, period);
  }

  Widget _leftTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text = '';
    switch (value.toInt()) {
      case 500:
        text = "500";
        break;
      case 1000:
        text = '1k';
        break;
      case 1500:
        text = '1.5k';
        break;
      case 2000:
        text = '2k';
        break;
      case 2500:
        text = '2.5k';
        break;
      case 3000:
        text = '3k';
        break;
      case 3500:
        text = '3.k';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  double _getMaxCo2Value() {
    var max = points.reduce((c, n) => c.co2 > n.co2 ? c : n).co2.toDouble();
    return max;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodProv = ref.watch(periodNotifierProvider);

    return OrientationBuilder(
      builder: (context, orientation) {
        return AspectRatio(
          aspectRatio: orientation == Orientation.portrait ? 2 : 3,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
              bottom: 5,
            ),
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: points
                        .map(
                          (point) => FlSpot(
                            points.indexOf(point).toDouble(),
                            point.co2.toDouble(),
                          ),
                        )
                        .toList(),
                    barWidth: 4,
                    isCurved: false,
                    dotData: const FlDotData(show: false),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  LineChartBarData(
                    spots: points
                        .map(
                          (point) => FlSpot(
                            points.indexOf(point).toDouble(),
                            800,
                          ),
                        )
                        .toList(),
                    isCurved: false,
                    dotData: const FlDotData(show: false),
                    color: Colors.green.withOpacity(0.5),
                  ),
                  LineChartBarData(
                    spots: points
                        .map(
                          (point) => FlSpot(
                            points.indexOf(point).toDouble(),
                            1000,
                          ),
                        )
                        .toList(),
                    isCurved: false,
                    dotData: const FlDotData(show: false),
                    color: Colors.orange.withOpacity(0.5),
                  ),
                  LineChartBarData(
                    spots: points
                        .map(
                          (point) => FlSpot(
                            points.indexOf(point).toDouble(),
                            1200,
                          ),
                        )
                        .toList(),
                    isCurved: false,
                    dotData: const FlDotData(show: false),
                    color: Colors.red.withOpacity(0.5),
                  ),
                ],
                minY: 0,
                maxY: max(_getMaxCo2Value() + 300, 1500),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval:
                            _getInterval(context, periodProv.value!.period)
                                .toDouble(),
                        reservedSize: 30,
                        getTitlesWidget: _bottomTitleWidget),
                  ),
                  leftTitles: AxisTitles(
                    // axisNameSize: 30,
                    // axisNameWidget: Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     "CO2",
                    //     style: TextStyle(
                    //       fontSize:
                    //           MediaQuery.of(context).size.height * 0.01 * 1.7,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: 500,
                        reservedSize: 40,
                        getTitlesWidget: _leftTitleWidget),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: 500,
                        reservedSize: 40,
                        getTitlesWidget: _leftTitleWidget),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval:
                      _getInterval(context, periodProv.value!.period)
                          .toDouble(),
                  checkToShowHorizontalLine: (double value) {
                    return value == 500 ||
                        value == 1000 ||
                        value == 1500 ||
                        value == 2000 ||
                        value == 2500 ||
                        value == 3000 ||
                        value == 3500;
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
