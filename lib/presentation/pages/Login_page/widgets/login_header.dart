import 'package:flutter/material.dart';
import 'package:workout_app/constants.dart';

const creamWhite = Color.fromARGB(255, 252, 251, 244);

class LoginHeader extends StatelessWidget {
  const LoginHeader(
      {super.key, required this.heading, required this.subHeading});
  final String heading;
  final String subHeading;
  final TextStyle _textStyleBig = const TextStyle(
    color: creamWhite,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );
  final TextStyle _textStyleSmall = const TextStyle(
    color: creamWhite,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 10, 30, 46),
      padding: const EdgeInsets.only(left: kBigPadding, bottom: kHugePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(heading, style: _textStyleBig),
          Text(subHeading, style: _textStyleSmall),
        ],
      ),
    );
  }
}
