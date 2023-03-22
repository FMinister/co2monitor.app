import 'package:co2app/components/static_lines.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<StaticLines> points;

  const LineChartWidget(this.points, {Key? key}) : super(key: key);

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
                        .map((point) => FlSpot(point.x, point.y))
                        .toList(),
                    isCurved: false,
                    dotData: FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: points
                        .map((point) => FlSpot(point.x, point.y))
                        .toList(),
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    color: Colors.red,
                  ),
                ],
                minY: 0,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 35,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      reservedSize: 36,
                    ),
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
                  verticalInterval: 1,
                  // checkToShowVerticalLine: (double value) {
                  //   return value == 1 || value == 3 || value == 5;
                  // },
                  checkToShowHorizontalLine: (double value) {
                    return value == 1 || value == 6 || value == 4 || value == 5;
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
