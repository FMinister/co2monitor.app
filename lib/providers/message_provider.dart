import 'package:flutter/material.dart';

class MessageProvider with ChangeNotifier {
  final bool _showSnackbar = false;

  bool get showSnackbar => _showSnackbar;

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 30,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontSize: 30,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showLoadingSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Center(
          child: SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }

  void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
