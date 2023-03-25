import 'package:co2app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/message_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final periods = [1, 3, 6, 12, 24, 48];

  Future<void> onTabPeriod(BuildContext context, int period) async {
    try {
      Provider.of<MessageProvider>(context, listen: false)
          .hideSnackBar(context);
      Provider.of<MessageProvider>(context, listen: false)
          .showLoadingSnackBar(context);
      await Provider.of<DataProvider>(context, listen: false).setPeriod(period);
      if (context.mounted) {
        Provider.of<MessageProvider>(context, listen: false)
            .showSuccessSnackBar(context, "Data successfully refreshed!");
      }
    } catch (error) {
      Provider.of<MessageProvider>(context, listen: false)
          .showErrorSnackBar(context, error.toString());
      Scaffold.of(context).closeDrawer();
    } finally {
      Provider.of<MessageProvider>(context, listen: false)
          .hideSnackBar(context);
      Scaffold.of(context).closeDrawer();
    }
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
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: periods.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    Icons.update,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    "${periods[index]} ${periods[index] > 1 ? "hours" : "hour"}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  onTap: () async => await onTabPeriod(context, periods[index]),
                );
              }),
        ],
      ),
    );
  }
}
