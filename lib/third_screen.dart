import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/screen.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScreen(
      imagePath: "assets/relax.gif",
      title: 'Relax and Unwind',
      description:
          'hope to take the courage to do what makes you happy every day',
      nextScreen: Screen1(),
      currentPage: 2,
    );
  }
}

