import 'package:flutter/material.dart';

class ButtonLoadingSpinner extends StatelessWidget {
  const ButtonLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(),
    );
  }
}
