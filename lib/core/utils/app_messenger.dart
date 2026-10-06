import 'package:flutter/material.dart';

/// Lets non-widget code (services, controllers) surface a message without
/// needing a BuildContext.
class AppMessenger {
  AppMessenger._();

  static final GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void show(String message) {
    key.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
        ),
      );
  }
}
