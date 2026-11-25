import 'package:flutter/material.dart';

/// Діалог з результатом запиту: успіх або помилка
Future<void> showResultDialog(
    BuildContext context, {
      required bool success,
      required String message,
    }) {
  return showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        title: Text(success ? 'Успіх' : 'Помилка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}