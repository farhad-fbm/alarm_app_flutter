import 'package:flutter/material.dart';
import 'package:my_app/helpers/location_helper.dart';
import 'package:my_app/constants/app_colors.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? savedLocation = LocationHelper.getSavedLocation();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("Alarms"),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Text(
          savedLocation != null
              ? "Selected Location: $savedLocation"
              : "No location saved",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
