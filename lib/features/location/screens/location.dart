import 'package:flutter/material.dart';
import 'package:my_app/common_widgets/custom_location_button.dart';
import 'package:my_app/constants/app_colors.dart';

class SetLocation extends StatelessWidget {
  const SetLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                'Welcome! Your Personalized Alarm',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Allow us to sync your sunset alarm based on your location.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              SizedBox(height: 32),
              Image.asset(
                'assets/morning_location.png',
                height: 300,
                fit: BoxFit.cover,
              ),

              Spacer(),
              CustomLocationButton(
                onClick: () {
                  // Handle location permission request
                },
                btnText: "Use Current Location",
                icon: Icons.location_on,
              ),
              SizedBox(height: 16),
              CustomLocationButton(btnText: 'Home'),
            ],
          ),
        ),
      ),
    );
  }
}
