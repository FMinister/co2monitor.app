import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/message_provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends ConsumerState<AppDrawer> {
  final periods = [1, 3, 6, 12, 24, 48];
  var _isLoading = false;

  Future<void> onTabPeriod(int period) async {}

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
                  onTap: () async => await onTabPeriod(periods[index]),
                );
              }),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}
