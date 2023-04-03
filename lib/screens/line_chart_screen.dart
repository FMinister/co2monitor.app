import 'dart:async';

import 'package:co2app/providers/date_format_provider.dart';
import 'package:co2app/providers/message_provider.dart';
// import 'package:co2app/widgets/app_drawer.dart';
import 'package:co2app/widgets/temp_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/data_provider.dart';
import '../widgets/co2_line_chart.dart';

class LineChartScreen extends ConsumerStatefulWidget {
  const LineChartScreen({super.key});

  @override
  _LineChartScreenState createState() => _LineChartScreenState();
}

class _LineChartScreenState extends ConsumerState<LineChartScreen> {
  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(dataProvider);
    fetchLatestDataEveryMinute();
  }

  Future<void> fetchLatestDataEveryMinute() async {
    Timer.periodic(const Duration(seconds: 60), (_) async {
      final test = await ref.read(dataProvider.future);
      print(test.length);
    });
  }

  // Future<void> _onTabRefresh(BuildContext context) async {
  //   final messageProvider =
  //       Provider.of<MessageProvider>(context, listen: false);
  //   final dataProvider = Provider.of<DataProvider>(context, listen: false);

  //   messageProvider.hideSnackBar(context);
  //   try {
  //     messageProvider.showLoadingSnackBar(context);
  //     Future.wait([
  //       dataProvider.fetchLatestData(),
  //       dataProvider.fetchAndSetData(),
  //     ]);
  //     if (context.mounted) {
  //       messageProvider.showSuccessSnackBar(
  //           context, "Data successfully refreshed!");
  //     }
  //   } catch (error) {
  //     messageProvider.showErrorSnackBar(context, error.toString());
  //   } finally {
  //     messageProvider.hideSnackBar(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final dataProv = ref.watch(fetchDataProvider);
    final latestDataProv = ref.watch(fetchLatestDataProvider);
    final dateFormatter = ref.watch(dateFormatterProvider);

    return dataProv.when(
      data: (data) => ListView(
        children: <Widget>[
          latestDataProv.when(
            data: (latestData) => Center(
              child: Text(
                "${dateFormatter.format(latestData.date)}, CO2: ${latestData.co2}, Temp: ${latestData.temp}, Period: 6h",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            error: (err, _) => Center(
              child: Text("Data could not be loaded: \n$err"),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Co2LineChartWidget(data),
          Divider(
            color: Theme.of(context).colorScheme.outline,
          ),
          TempLineChartWidget(data),
        ],
      ),
      error: (err, _) => Center(
        child: Text("Data could not be loaded: \n$err"),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
