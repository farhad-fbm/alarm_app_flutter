import 'package:flutter/material.dart';
import 'package:my_app/features/location/screens/location.dart';
import 'package:my_app/features/onboarding/screens/info_screen.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScreen(
      imagePath: "assets/relax.gif",
      title: 'Relax and Unwind',
      description:
          'hope to take the courage to do what makes you happy every day',
      nextScreen: SetLocation(),
      currentPage: 2,
    );
  }
}

