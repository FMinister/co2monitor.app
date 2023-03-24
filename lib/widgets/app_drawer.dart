import 'package:co2app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var periods = [1, 3, 6, 12, 24, 48];

  @override
  void initState() {
    super.initState();
  }

  Future<void> onTabPeriod(BuildContext context, int period) async {
    Scaffold.of(context).closeDrawer();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      );
      // await Provider.of<DataProvider>(context, listen: false).setPeriod(period);
      Future.wait([
        Provider.of<DataProvider>(context, listen: false).setPeriod(period),
        Provider.of<DataProvider>(context, listen: false).fetchAndSetData(),
      ]);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            content: Text(
              "Period successfully saved.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          content: Text(
            "Data couldn't be refreshed.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 16,
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
          // ListTile(
          //   leading: Icon(
          //     Icons.update,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   title: const Text("1"),
          //   onTap: () {},
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme.outline,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.update,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   title: const Text("1"),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed("/");
          //   },
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme.outline,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.update,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   title: const Text("1"),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed("/");
          //   },
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme.outline,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.update,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   title: const Text("1"),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed("/");
          //   },
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme.outline,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.update,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   title: const Text("1"),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed("/");
          //   },
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme.outline,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.update,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          //   title: const Text("1"),
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed("/");
          //   },
          // ),
          // Divider(
          //   color: Theme.of(context).colorScheme.outline,
          // ),
        ],
      ),
    );
  }
}
