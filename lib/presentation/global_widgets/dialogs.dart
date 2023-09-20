import 'package:flutter/material.dart';

void showDeleteDialog(
  BuildContext context, {
  required Function confirmationFunction,
  required String title,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("Möchtest du $title löschen ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () => confirmationFunction(),
            child: const Text("Löschen"),
          ),
        ],
      );
    },
  );
}
