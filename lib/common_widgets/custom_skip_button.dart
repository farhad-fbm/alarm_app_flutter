import 'package:flutter/material.dart';

class CustomSkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomSkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      right: 16,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black26,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Text("Skip", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
