import 'package:flutter/material.dart';
import 'package:my_app/common_widgets/custom_skip_button.dart';

class InfoCard extends StatelessWidget {
  final String imagePath;
  final VoidCallback onSkip;

  const InfoCard({super.key, required this.imagePath, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55,
            fit: BoxFit.cover,
          ),
          // Skip button positioned absolutely
        CustomSkipButton(onPressed: onSkip),
        ],
      ),
    );
  }
}

