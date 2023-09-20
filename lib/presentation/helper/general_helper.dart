import 'package:flutter/material.dart';

double getScreenHeightwithoutAppBarAndStatusBar(BuildContext context) {
  final statusbarHeight = MediaQuery.of(context).viewPadding.top;
  final double screenHeight = MediaQuery.of(context).size.height;
  return screenHeight - kToolbarHeight - statusbarHeight;
}
