import 'package:flutter/material.dart';
import 'package:my_app/features/onboarding/screens/first_screen.dart';

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
