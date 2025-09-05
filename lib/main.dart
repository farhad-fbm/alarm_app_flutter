import 'package:flutter/material.dart';
import 'package:my_app/features/onboarding/screens/info_screen.dart';
import 'package:my_app/second_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Alarm App",
      home: Screen1(),
    );
  }
}

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoScreen(
      imagePath: "assets/sync_rhythm.gif",
      title: 'Sync with Nature’s Rhythm',
      description:
          'Experience a peaceful transition into the evening with an alarm that aligns with the sunset."Your perfect reminder, always 15 minutes before sundown',
      nextScreen: Screen2(),
      currentPage: 0,
    );
  }
}
