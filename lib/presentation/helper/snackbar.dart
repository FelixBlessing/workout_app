import 'package:flutter/material.dart';

void showSnackbar(String text, BuildContext context,
    {VoidCallback? onDismiss}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      content: Text(text),
    ),
  );
  onDismiss?.call();
}
