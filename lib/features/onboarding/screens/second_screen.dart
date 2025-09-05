import 'package:flutter/material.dart';
import 'package:my_app/features/onboarding/screens/info_screen.dart';
import 'package:my_app/features/onboarding/screens/third_screen.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScreen(
      imagePath: "assets/effortless.gif",
      title:  'Effortless and Automatic',
      description:
         'No need to set alarms manually. Wakey calculates the sunset time for your location and alerts you on time',
      nextScreen: Screen3(),
      currentPage: 1,
    );
  }
}
