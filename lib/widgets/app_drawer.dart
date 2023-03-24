import 'package:co2app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _period = 6;

  @override
  void initState() {
    setState(() {
      _period = Provider.of<DataProvider>(context, listen: false).period;
    });
    super.initState();
  }

  void onTabPeriod(int period) {
    Provider.of<DataProvider>(context, listen: false).setPeriod(period);
    setState(() {
      _period = period;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              "Set time period",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                );
              },
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.outline,
          )
        ],
      ),
    );
  }
}
