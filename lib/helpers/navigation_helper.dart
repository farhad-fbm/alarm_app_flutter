import 'package:flutter/material.dart';

void navigationWithFade(
  BuildContext context,
  Widget destination, {
  int durationMs = 300,
}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, animation, _) => destination,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: Duration(milliseconds: durationMs),
    ),
  );
}
