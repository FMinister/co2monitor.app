import 'package:co2app/providers/data_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Co2LineChartWidget extends StatelessWidget {
  final List<Co2Data> points;
  final int period;

  const Co2LineChartWidget(this.points, this.period, {Key? key})
      : super(key: key);

  Widget _bottomTitleWidget(double value, TitleMeta meta) {
    const style = TextStyle(
      // fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    var text = DateFormat("HH:mm").format(points[value.toInt()].date);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  int _getInterval(int period) {
    switch (period) {
      case 1:
        return 5;
      case 3:
        return 10;
      case 6:
        return 20;
      case 12:
        return 40;
    }
    return 10;
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

  double getMaxCo2Value() {
    var max = points.reduce((c, n) => c.co2 > n.co2 ? c : n).co2.toDouble();
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return AspectRatio(
          aspectRatio: orientation == Orientation.portrait ? 2 : 3,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 28,
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
                    dotData: FlDotData(show: false),
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
                    dotData: FlDotData(show: false),
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
                    dotData: FlDotData(show: false),
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
                    dotData: FlDotData(show: false),
                    color: Colors.red.withOpacity(0.5),
                  ),
                ],
                minY: 0,
                maxY: getMaxCo2Value() + 300,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: _getInterval(period).toDouble(),
                        reservedSize: 50,
                        getTitlesWidget: _bottomTitleWidget),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        interval: 500,
                        reservedSize: 50,
                        getTitlesWidget: _leftTitleWidget),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 1,
                  verticalInterval: _getInterval(period).toDouble(),
                  // checkToShowVerticalLine: (double value) {
                  //   return value == 1 || value == 3 || value == 5;
                  // },
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
