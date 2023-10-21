import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "message_provider.g.dart";

@riverpod
class MessageStateNotifier extends _$MessageStateNotifier {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void build() {}

  void showSuccessSnackBar(BuildContext context, String message) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.01 * 2,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String errorMessage) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.01 * 2,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showLoadingSnackBar(BuildContext context) {
    scaffoldKey.currentState?.showSnackBar(
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
    scaffoldKey.currentState?.hideCurrentSnackBar();
  }
}

// class MessageProvider with ChangeNotifier {
//   final bool _showSnackbar = false;

//   bool get showSnackbar => _showSnackbar;

//   void showSuccessSnackBar(BuildContext context, String message) {
//     scaffoldKey.currentState?.showSnackBar(
//       SnackBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.primary,
//             fontSize: 30,
//           ),
//         ),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void showErrorSnackBar(BuildContext context, String errorMessage) {
//     scaffoldKey.currentState?.showSnackBar(
//       SnackBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         content: Text(
//           errorMessage,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.error,
//             fontSize: 30,
//           ),
//         ),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }

//   void showLoadingSnackBar(BuildContext context) {
//     scaffoldKey.currentState?.showSnackBar(
//       SnackBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         content: Center(
//           child: SizedBox(
//             width: 35,
//             height: 35,
//             child: CircularProgressIndicator(
//               color: Theme.of(context).colorScheme.primary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void hideSnackBar(BuildContext context) {
//     scaffoldKey.currentState?.hideCurrentSnackBar();
//   }
// }
