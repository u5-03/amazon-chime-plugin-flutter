import 'package:flutter/material.dart';

extension DialogExt on AlertDialog {
  static void showMessageAlert({
    required String message,
    required BuildContext context,
    String buttonText = 'OK',
  }) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: Text(buttonText),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
