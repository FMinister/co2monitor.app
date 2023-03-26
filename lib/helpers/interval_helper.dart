import 'package:co2app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IntervallHelper {
  int calculateInterval(BuildContext context) {
    int interval = 30;
    int period = Provider.of<DataProvider>(context, listen: false).period;
    double width = MediaQuery.of(context).size.width;
    if (width < 400) interval = 150;
    if (width < 600) interval = 120;
    if (width < 900) interval = 90;
    if (width < 1200) interval = 60;
    if (period == 24) interval = (interval * 4).round();
    if (period == 48) interval = (interval * 8).round();
    print(interval);
    return interval;
  }
}
