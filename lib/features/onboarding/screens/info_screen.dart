import 'package:flutter/material.dart';
import 'package:my_app/common_widgets/custom_indicator.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/features/onboarding/widgets/info_card.dart';
import 'package:my_app/features/onboarding/widgets/info_content.dart';
import 'package:my_app/features/location/screens/location.dart';
import 'package:my_app/helpers/navigation_helper.dart';

class InfoScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Widget nextScreen;
  final int currentPage;

  const InfoScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.nextScreen,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            InfoCard(
              imagePath: imagePath,
              onSkip: () {
                navigationWithFade(context, const SetLocation());
              },
            ),
            SizedBox(height: 16),
            InfoContent(title: title, description: description),
            Spacer(),
            CustomIndicator(currentPage: currentPage, totalPages: 3),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  navigationWithFade(context, nextScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("NEXT", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
