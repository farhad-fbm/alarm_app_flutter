import 'package:flutter/material.dart';
import 'package:my_app/common_widgets/custom_location_button.dart';
import 'package:my_app/constants/app_colors.dart';
import 'package:my_app/features/alarms/screens/alarm_screen.dart';
// import 'package:my_app/features/alarms/screens/alarm_screen.dart';
import 'package:my_app/helpers/location_helper.dart';
import 'package:my_app/helpers/navigation_helper.dart';

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  String? _status;
  bool _isLoading = false;

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
              // ---------------------------------------------------
              if (_status != null)
                Text(_status!, style: TextStyle(color: Colors.white70)),
              // --------------------------------------------------------
              SizedBox(height: 16),
              CustomLocationButton(
                onClick: () async {
                  setState(() => _isLoading = true); // show loading

                  try {
                    String? result = await LocationHelper.getAndSaveLocation();
                    setState(() {
                      _status = result;
                      _isLoading = false; // hide loading
                    });
                    if (!mounted) return;
                    if (result != null &&
                        !result.toLowerCase().contains("denied")) {
                      navigationWithFade(context, const AlarmScreen());
                    }
                  } catch (e) {
                    setState(() {
                      _status = "Error fetching location";
                      _isLoading = false;
                    });
                  }
                },
                btnText: "Use Current Location",
                icon: Icons.location_on,
              ),
              if (_isLoading) CircularProgressIndicator(),
              SizedBox(height: 16),
              CustomLocationButton(
                btnText: 'Home',
                onClick: () => navigationWithFade(context, const AlarmScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
