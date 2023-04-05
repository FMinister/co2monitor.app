import 'package:flutter/material.dart';

class IntervallHelper {
  int calculateInterval(BuildContext context, int period) {
    int interval = 10;
    double width = MediaQuery.of(context).size.width;
    switch (period) {
      case 1:
        interval = (interval).round();
        break;
      case 3:
        interval = (interval * 3).round();
        break;
      case 6:
        interval = (interval * 6).round();
        break;
      case 12:
        interval = (interval * 12).round();
        break;
      case 24:
        interval = (interval * 24).round();
        break;
      case 48:
        interval = (interval * 48).round();
        break;
    }

    if (width > 800 && width < 1200) {
      interval = (interval / 2).round();
    }
    if (width >= 1200) {
      interval = (interval / 4).round();
    }

    return interval;
  }
}
