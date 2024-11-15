import 'package:flutter/material.dart';

class DialogService {
  final GlobalKey<NavigatorState> navigatorKey;

  DialogService(this.navigatorKey);

  void showAlert(String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"))
          ],
        );
      },
    );
  }
}
